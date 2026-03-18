#!/usr/bin/env python3
"""
GooglePro AI Build Fix Script
Uses Claude API to automatically diagnose and fix Flutter build errors.
Runs up to 20 iterations until the build succeeds.
"""
import os
import subprocess
import json
import sys
import time
import urllib.request
import urllib.error

ANTHROPIC_API_KEY = os.environ.get("ANTHROPIC_API_KEY", "")
MODEL = "claude-sonnet-4-20250514"
MAX_ITERATIONS = 20
BUILD_COMMAND = ["flutter", "build", "apk", "--release", "--no-shrink"]

SYSTEM_PROMPT = """You are an expert Flutter/Dart developer specializing in debugging build errors.
When given a Flutter build error, you MUST:
1. Identify the exact file and line causing the error
2. Provide the COMPLETE fixed file content (not just a snippet)
3. Explain the fix in 1-2 sentences
4. Output ONLY valid JSON in this exact format:
{
  "file_path": "lib/path/to/file.dart",
  "fixed_content": "complete file content here",
  "explanation": "brief explanation"
}
If multiple files need fixing, output only the most critical one.
Do NOT output anything outside the JSON object."""

def run_build():
    result = subprocess.run(BUILD_COMMAND, capture_output=True, text=True, cwd=os.getcwd())
    return result.returncode, result.stdout + result.stderr

def get_file_content(file_path):
    try:
        with open(file_path, "r") as f:
            return f.read()
    except FileNotFoundError:
        return None

def write_file(file_path, content):
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, "w") as f:
        f.write(content)

def call_claude(error_output, iteration):
    url = "https://api.anthropic.com/v1/messages"
    headers = {
        "x-api-key": ANTHROPIC_API_KEY,
        "anthropic-version": "2023-06-01",
        "content-type": "application/json"
    }
    # Include relevant file content if error mentions a specific file
    file_context = ""
    for line in error_output.split("\n"):
        if "lib/" in line and ".dart:" in line:
            parts = line.split("lib/")
            if len(parts) > 1:
                fp = "lib/" + parts[1].split(":")[0]
                content = get_file_content(fp)
                if content:
                    file_context += f"\n\nCurrent content of {fp}:\n```dart\n{content[:3000]}\n```"
                    break

    payload = {
        "model": MODEL,
        "max_tokens": 4096,
        "system": SYSTEM_PROMPT,
        "messages": [{
            "role": "user",
            "content": f"Flutter build error (iteration {iteration}/{MAX_ITERATIONS}):\n\n```\n{error_output[-4000:]}\n```{file_context}\n\nFix this error. Output only valid JSON."
        }]
    }

    req = urllib.request.Request(url, data=json.dumps(payload).encode(), headers=headers, method="POST")
    try:
        with urllib.request.urlopen(req, timeout=60) as resp:
            return json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        print(f"Claude API error: {e.code} {e.read().decode()}")
        return None

def parse_fix(response):
    if not response or "content" not in response:
        return None
    text = response["content"][0]["text"]
    # Strip markdown code fences if present
    text = text.strip()
    if text.startswith("```"):
        text = "\n".join(text.split("\n")[1:])
    if text.endswith("```"):
        text = "\n".join(text.split("\n")[:-1])
    try:
        return json.loads(text.strip())
    except json.JSONDecodeError as e:
        print(f"JSON parse error: {e}")
        print(f"Raw response: {text[:500]}")
        return None

def main():
    if not ANTHROPIC_API_KEY:
        print("ERROR: ANTHROPIC_API_KEY not set")
        sys.exit(1)

    print(f"GooglePro AI Build Fix — max {MAX_ITERATIONS} iterations")
    print("="*60)

    for iteration in range(1, MAX_ITERATIONS + 1):
        print(f"\n[{iteration}/{MAX_ITERATIONS}] Building...")
        code, output = run_build()

        if code == 0:
            print(f"✅ Build succeeded on iteration {iteration}!")
            # Save successful APK
            subprocess.run(["mkdir", "-p", "outputs"])
            subprocess.run(["cp", "build/app/outputs/flutter-apk/app-release.apk", "outputs/GooglePro-release.apk"])
            sys.exit(0)

        print(f"❌ Build failed. Asking Claude to fix...")
        print(f"Error snippet: {output[-500:]}")

        response = call_claude(output, iteration)
        fix = parse_fix(response)

        if not fix:
            print(f"Could not parse Claude response. Retrying in 5s...")
            time.sleep(5)
            continue

        file_path = fix.get("file_path", "")
        content = fix.get("fixed_content", "")
        explanation = fix.get("explanation", "No explanation")

        if not file_path or not content:
            print("Invalid fix response. Continuing...")
            continue

        print(f"🔧 Fixing: {file_path}")
        print(f"   Reason: {explanation}")
        write_file(file_path, content)
        time.sleep(2)

    print(f"\n❌ Build failed after {MAX_ITERATIONS} iterations.")
    sys.exit(1)

if __name__ == "__main__":
    main()
