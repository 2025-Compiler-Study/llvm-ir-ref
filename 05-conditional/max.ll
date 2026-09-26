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
  %a      = call i32 @read()
  %b      = call i32 @read()
  %result = alloca i32
  %cond   = icmp sgt i32 %a, %b
  br i1 %cond, label %pick_a, label %pick_b

pick_a:
  store i32 %a, ptr %result
  br label %end

pick_b:
  store i32 %b, ptr %result
  br label %end

end:
  %out = load i32, ptr %result
  call void @write(i32 %out)
  ret i32 0
}
