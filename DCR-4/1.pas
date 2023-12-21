program z1;

uses CRT,GraphABC;
const
  NORM = White; 
  SEL = lightMagenta;
  K = 2;

var
  menu: array[1..K] of string;
  punkt: integer;
  ch: char;
  x_menu, y_menu: integer;

function f(x: real): real;
begin
  f := (2*power(x,3)+(-2)*power(x,2)+(-2)*x+4);
end;

function fb(var x: real): real;
begin
  fb := (1/2)*power(x,4)-(2/3)*power(x,3)-power(x,2)+4*x;
end;
function metod_trap(n:int64;a,b:real):real;
var hz,x,h:real; i:int64;
begin
  h:=(b-a)/n;
  x:=a;
  for i:=1 to n-1 do
    begin
    hz+=f(x);
    x+=h;
    end;
  metod_trap:=(h/2)*(f(a)+f(b-h))+h*hz;  
end;
var
  x, h, a, b, sum_f, fun, integral, f_a, f_b, error: real;
  N,kk: integer;

procedure DrawGraph;
var
  gx, gy, x0, y0, x1, y1, i: integer;
  x, y: real;
begin
  ClearWindow;
  SetBrushColor(clWhite);
  gx := N * 10 + 30;
  gy := 700;
  SetWindowSize(gx, gy);
  x0 := 20;
  y0 := gy - 100;
  Line(x0, y0, trunc(gx+h*kk*10), y0);
  TextOut(trunc(gx+h*kk*20), y0 + 10, 'X');
  Line(x0, 10, x0, y0);
  TextOut(x0 - 10, 20, 'Y');

  for i := 0 to N do
  begin
    Line(x0 + (i * kk), y0 - kk, x0 + (i * kk), y0 + kk);
    TextOut(x0 + (i * kk), y0 + kk, IntToStr(i));
  end;

  for i := -N to 0 do
  begin
    Line(x0 - kk, y0 + (i * kk), x0 + kk, y0 + (i * kk));
    if i <> 0 then
      TextOut(x0 + k, y0 + (i * kk), IntToStr(-i));
  end;

x := a;
  MoveTo(x0, y0 - Trunc((2*power(x,3)+(-2)*power(x,2)+(-2)*x+4) * kk));

  while x <= b do
  begin
    y := 2*power(x,3)+(-2)*power(x,2)+(-2)*x+4; { функция }
    x1 := Trunc(x0 + x * kk);
    y1 := Trunc(y0 - Trunc(y * kk)); { экранные координаты }
    setPixel(x1, y1,clRed);
    x := x + 0.001;
  end;
  x := a;
  MoveTo(x0, y0 - Trunc((2*power(x,3)+(-2)*power(x,2)+(-2)*x+4) * kk));

  while x <= b do
  begin
    y := 2*power(x,3)+(-2)*power(x,2)+(-2)*x+4; { функция }
    x1 := Trunc(x0 + x * kk);
    y1 := Trunc(y0 - Trunc(y * kk)); { экранные координаты }
    setPenColor(clGreen);
    line(x1,y0,trunc(x0+(x+h)*kk),y0-trunc(f(x+h)*kk));
    line(trunc(x0+(x+h)*kk),y0,x1,y1);
    line(x1,y0,x1,y1);
    LineTo(x1 + Trunc(h), y1);
    x := x + h;
    setPenColor(clBlack);
  end;
end;

procedure KeyDown(Key: integer);
begin
  case Key of
    VK_Up:   kk := kk + 5;
    VK_Down: kk := kk - 5;
  end;

  DrawGraph;
end;

procedure PlotGraph(a, b, h: real; N: integer);
begin
  kk := 10;
  OnKeyDown := KeyDown;

  DrawGraph;
end;

procedure punkt1;
begin
  ClrScr;
  var i: integer;
  repeat
  begin
    write('Введите количество разделений: ');
    readln(N);
    write('Введите начало интрегрирования: ');
    readln(a);
    write('Введите конец интрегрирования: ');
    readln(b);
    CLRSCR;
    h := (b - a) /N;
    x := a;
    sum_f := metod_trap(n,a,b);
    f_a := fb(a);
    f_b := fb(b);
    integral := f_b - f_a;
    sum_f := abs(sum_f);
    error := integral-sum_f;
    writeln('Результат вычислений:', sum_f);
    writeln('Абсолютная погрешность: ', error);
    PlotGraph(a,b,h,N);
    writeln('<<Enter чтобы выйти в меню>>');
    ch := readkey;
    end;
  until ch = #13;
end;

procedure MenuToScr;
var
  i: integer;
begin
  ClrScr;
  for i := 1 to K do
  begin
    GoToXY(x_menu, y_menu + i - 1);
    write(menu[i]);
  end;
  TextColor(SEL);
  GoToXY(x_menu, y_menu + punkt - 1);
  write(menu[punkt]);
  TextColor(NORM);
end;

begin
  SetConsoleIO;
  menu[1] := ' Найти интеграл '; 
  menu[2] := ' Выход ';
  punkt := 1; 
  x_menu := 2; 
  y_menu := 2; 
  TextColor(NORM);
  MenuToScr;
  repeat
    ch := ReadKey;
    if ch = #0 then
    begin
      ch := ReadKey;
      case ch of
        #40: {Вниз}
          if punkt < K then
          begin
            GoToXY(x_menu, y_menu + punkt - 1);
            write(menu[punkt]);
            punkt := punkt + 1;
            TextColor(SEl);
            GoToXY(x_menu, y_menu + punkt - 1);
            write(menu[punkt]);
            TextColor(NORM);
          end;
        #38: {Вверх}
          if punkt > 1 then
          begin
            GoToXY(x_menu, y_menu + punkt - 1);
            write(menu[punkt]);
            punkt := punkt - 1;
            TextColor(SEl);
            GoToXY(x_menu, y_menu + punkt - 1);
            write(menu[punkt]);
            TextColor(NORM);
          end;
      end;
    end
    else
    if ch = #13 then
    begin
      case punkt of
        1: punkt1;
        2: ch := #27;
      end;
      MenuToScr;
    end;
  until ch = #27;
end.