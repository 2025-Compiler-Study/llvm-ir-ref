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
  %a = call i32 @read()
  %b = call i32 @read()
  %c = call i32 @read()
  %d = call i32 @read()

  %x1 = add i32 %a, %b   ; ①
  %y  = mul i32 %x1, 2   ; ②  RAW(①)
  %x2 = add i32 %c, %d   ; ③  WAR(②), WAW(①) 가 의사코드에서 생기던 자리
  %z  = add i32 %x2, 1   ; ④  RAW(③)

  call void @write(i32 %x2)
  call void @write(i32 %y)
  call void @write(i32 %z)
  ret i32 0
}
