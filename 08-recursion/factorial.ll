declare i32 @printf(ptr, ...)
declare i32 @scanf(ptr, ...)

@.rfmt = private constant [3 x i8]  c"%d\00"
@.wfmt = private constant [4 x i8]  c"%d\0A\00"

define i32 @read() {
  %buf = alloca i32
  call i32 (ptr, ...) @scanf(ptr @.rfmt, ptr %buf)
  %val = load i32, ptr %buf
  ret i32 %val
}

define void @write(i32 %n) {
  call i32 (ptr, ...) @printf(ptr @.wfmt, i32 %n)
  ret void
}

define i32 @factorial(i32 %n) {
  %cond = icmp eq i32 %n, 0
  br i1 %cond, label %base, label %recurse

base:
  ret i32 1

recurse:
  %n1      = sub i32 %n, 1
  %sub_ret = call i32 @factorial(i32 %n1)
  %result  = mul i32 %n, %sub_ret
  ret i32 %result
}

define i32 @main() {
  %n    = call i32 @read()
  %fact = call i32 @factorial(i32 %n)
  call void @write(i32 %fact)
  ret i32 0
}
