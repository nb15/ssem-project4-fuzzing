#include <assert.h>
#include <stdint.h>
#include <stddef.h>
#include <string>
#include <vector>
#include <algorithm>
#include <fuzzer/FuzzedDataProvider.h>

// Starter example only. Replace this with your own logic.
static std::vector<int> duplicate_evens(const std::vector<int>& xs) {
  std::vector<int> out;
  for (int x : xs) {
    out.push_back(x);
    if (x % 2 == 0) {
      out.push_back(x);
    }
  }
  return out;
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t* data, size_t size) {
  FuzzedDataProvider fdp(data, size);

  size_t n = fdp.ConsumeIntegralInRange<size_t>(0, 16);
  std::vector<int> xs;
  xs.reserve(n);
  for (size_t i = 0; i < n; i++) {
    xs.push_back(fdp.ConsumeIntegral<int>());
  }

  std::vector<int> ys = duplicate_evens(xs);

  // TODO: replace with your own property.
  // Example shape only:
  // output should contain at least as many elements as input
  // assert(ys.size() >= xs.size());

  (void)ys;
  return 0;
}
