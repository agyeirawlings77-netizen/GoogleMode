#!/usr/bin/env bash
set -e
echo "Running GooglePro tests..."
flutter test test/unit/ --reporter=compact
flutter test test/widget/ --reporter=compact
echo "All tests passed!"
