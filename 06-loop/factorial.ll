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

define i32 @main() {
  %n   = call i32 @read()
  %acc = alloca i32
  %i   = alloca i32
  store i32 1, ptr %acc
  store i32 1, ptr %i
  br label %loop

loop:
  %cur_i   = load i32, ptr %i
  %cur_acc = load i32, ptr %acc
  %cond    = icmp sle i32 %cur_i, %n
  br i1 %cond, label %body, label %end

body:
  %new_acc = mul i32 %cur_acc, %cur_i
  %new_i   = add i32 %cur_i, 1
  store i32 %new_acc, ptr %acc
  store i32 %new_i,   ptr %i
  br label %loop

end:
  %result = load i32, ptr %acc
  call void @write(i32 %result)
  ret i32 0
}
