#include <assert.h>
#include <stdint.h>
#include <stddef.h>
#include <string>
#include <fuzzer/FuzzedDataProvider.h>

// Starter example only. Replace this with your own logic.
static std::string normalize_word(const std::string& s, bool lowercase) {
  std::string out = s;
  if (lowercase) {
    for (char& c : out) {
      if (c >= 'A' && c <= 'Z') c = c - 'A' + 'a';
    }
  }
  return out;
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t* data, size_t size) {
  FuzzedDataProvider fdp(data, size);

  bool lowercase = fdp.ConsumeBool();
  std::string s = fdp.ConsumeRandomLengthString(32);

  std::string once = normalize_word(s, lowercase);
  std::string twice = normalize_word(once, lowercase);

  // TODO: replace with your own property.
  // Example shape only:
  // normalization should be idempotent
  // assert(once == twice);

  (void)once;
  (void)twice;
  return 0;
}
