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
  %half    = sdiv i32 %n, 2
  %doubled = mul  i32 %half, 2
  %cond    = icmp eq i32 %doubled, %n
  br i1 %cond, label %even, label %odd

even:
  ret i32 0

odd:
  ret i32 1
}

define i32 @factorial(i32 %n) {
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
  %out = load i32, ptr %acc
  ret i32 %out
}

define i32 @max(i32 %a, i32 %b) {
  %result = alloca i32
  %cond   = icmp sgt i32 %a, %b
  br i1 %cond, label %pick_a, label %pick_b

pick_a:
  store i32 %a, ptr %result
  br label %end_max

pick_b:
  store i32 %b, ptr %result
  br label %end_max

end_max:
  %out = load i32, ptr %result
  ret i32 %out
}

define i32 @main() {
  %n      = call i32 @read()
  %m      = call i32 @read()
  %parity = call i32 @is_odd(i32 %n)
  %fact   = call i32 @factorial(i32 %n)
  %mx     = call i32 @max(i32 %n, i32 %m)
  call void @write(i32 %parity)
  call void @write(i32 %fact)
  call void @write(i32 %mx)
  ret i32 0
}
