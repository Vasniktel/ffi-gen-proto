#include <stdint.h>

typedef int INT;
typedef const double CDOUBLE;

enum {
  A, B = 8, C = B << 1
} k;

struct S {
  int k;
  struct {
    int l;
  }* f;
};

typedef int (*TD)(int, long, enum E);

char K[];

TD td;

extern CDOUBLE global_var;

void test(int a, long b, uint8_t c, char d, uint64_t e, float p, char* str);
