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

define i32 @is_odd(i32 %n) {
  %c0 = icmp eq i32 %n, 0
  br i1 %c0, label %even, label %chk1

chk1:
  %c1 = icmp eq i32 %n, 1
  br i1 %c1, label %odd, label %recurse

even:
  ret i32 0

odd:
  ret i32 1

recurse:
  %n2      = sub i32 %n, 2
  %sub_ret = call i32 @is_odd(i32 %n2)
  ret i32 %sub_ret
}

define i32 @main() {
  %n      = call i32 @read()
  %parity = call i32 @is_odd(i32 %n)
  call void @write(i32 %parity)
  ret i32 0
}
