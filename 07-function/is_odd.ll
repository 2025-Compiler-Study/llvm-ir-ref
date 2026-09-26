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
  %result  = alloca i32
  %half    = sdiv i32 %n, 2
  %doubled = mul  i32 %half, 2
  %cond    = icmp eq i32 %doubled, %n
  br i1 %cond, label %even, label %odd

even:
  store i32 0, ptr %result
  br label %end

odd:
  store i32 1, ptr %result
  br label %end

end:
  %out = load i32, ptr %result
  ret i32 %out
}

define i32 @main() {
  %n      = call i32 @read()
  %parity = call i32 @is_odd(i32 %n)
  call void @write(i32 %parity)
  ret i32 0
}
