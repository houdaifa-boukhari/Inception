#!/bin/bash

echo "⏳ Testing FTP brute-force with 10 failed login attempts..."

for i in {1..10}; do
  echo -e "user invaliduser\npass wrongpassword\nquit" | ftp -n localhost > /dev/null
done

echo "✅ Finished sending login attempts."
