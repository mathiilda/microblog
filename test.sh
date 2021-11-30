while true; do
  make install-test
  make test
  make bandit
  break
done