unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Exit1: TMenuItem;
    Timer: TTimer;
    ConsoleDebug1: TMenuItem;
    PauseLabel: TLabel;
    TimerAdv: TTimer;
    Score01: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ConsoleDebug1Click(Sender: TObject);
    procedure TimerAdvTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  SnakeComp = array of integer;

  TSnake = class
    VectX: integer;
    VectY: integer;
    Level: integer;
    CoordX, CoordY: SnakeComp;
    Procedure Move;
    Procedure ChangeMove(X, Y: integer);
    Procedure Render;
    Procedure Eat;
    Procedure Defeat;
    Procedure LevelUp;
    Procedure Reboot;
    constructor create;
  end;

  TFood = class
    Level: integer;
    FX: integer;
    FY: integer;
    Color: TColor;
    Procedure Render;
    Procedure Respawn;
    constructor create;
  end;

var
  Form1: TForm1;
  DebugCall: Boolean = False;
  Snake: TSnake;
  Food: TFood;
  First: Boolean = True;
  Counter: integer = 0;


implementation

uses Unit2;

{$R *.dfm}

Procedure GameStart;
  begin
    Form1.Timer.Enabled := True;
    First := false;
    Form1.PauseLabel.Visible := false;
  end;

Procedure TSnake.LevelUp;
  begin
    Snake.Level := Snake.Level + Food.Level;
    SetLength(CoordX, Snake.Level);
    SetLength(CoordY, Snake.Level);
  end;

{Procedure SendAnalize;
  var
    i: integer;
  begin
    Unit2.DebugConsole.ConsoleMemo.Lines.Clear;
    Unit2.DebugConsole.ConsoleMemo.Lines.Add('Level = ' + IntToStr(Snake.Level));
    Unit2.DebugConsole.ConsoleMemo.Lines.Add('Refresh rate = ' + IntToStr(Form1.Timer.Interval));
    for i := 0 to Snake.Level - 1 do
      begin
        Unit2.DebugConsole.ConsoleMemo.Lines.Add('CoordX' + IntToStr(i) + ' = ' + IntToStr(CoordX[i]));
        Unit2.DebugConsole.ConsoleMemo.Lines.Add('CoordY' + IntToStr(i) + ' = ' + IntToStr(CoordY[i]));
      end;
  end;}

constructor TSnake.Create;
  const
    speed = 10;
  begin
    Level := 1;
    SetLength(CoordX, Level);
    SetLength(CoordY, Level);
    CoordX[0] := 400;
    CoordY[0] := 400;
    VectX := 0;
    VectY := -speed;
  end;

constructor TFood.Create;
  begin
    FX := 100;
    FY := 100;
    Level := 1;
    Color := clGreen;
  end;

Procedure TSnake.Eat;
  begin
    Snake.LevelUp;
    Counter := Counter + (Food.Level * 100);
    Form1.Score01.Caption := 'Score: ' + IntTostr(Counter);
    Food.Respawn;
  end;

Procedure TSnake.Move;
  const
    Rad = 10;
  var
    i: integer;
  begin
    if CoordX[0] < 0 then CoordX[0] := CoordX[0] + Form1.ClientWidth;
    if CoordY[0] < 0 then CoordY[0] := CoordY[0] + Form1.ClientHeight;
    if CoordX[0] > Form1.ClientWidth then CoordX[0] := CoordX[0] - Form1.ClientWidth;
    If CoordY[0] > Form1.ClientHeight then CoordY[0] := CoordY[0] - Form1.ClientHeight;
    if (Level > 1)
      then
        begin
          for i := 1 to (Level - 1) do
            begin
              CoordX[Level - i] := CoordX[Level - (i + 1)];
              CoordY[Level - i] := CoordY[Level - (i + 1)];
            end;
        end;
    CoordX[0] := CoordX[0] + VectX;
    CoordY[0] := CoordY[0] + VectY;
    if (Snake.CoordX[0] > Food.FX - Rad) and (Snake.CoordX[0] < Food.FX + Rad) and (Snake.CoordY[0] > Food.FY - Rad) and (Snake.CoordY[0] < Food.FY + Rad)
      then
        Snake.Eat;
    for i := 1 to (Snake.Level - 1) do
            begin
              if (Snake.CoordX[0] = Snake.CoordX[i]) and (Snake.CoordY[0] = Snake.CoordY[i])
                then
                  Snake.Defeat;
            end;
  end;

Procedure TSnake.ChangeMove(X, Y: integer);
  begin
    if Form1.TimerAdv.Enabled = False then
      begin
        VectX := X;
        VectY := Y;
        Form1.TimerAdv.Enabled := True;
      end;
  end;

Procedure TSnake.Render;
  const
    scale = 5;
  var
    i: integer;
  begin
    with Form1.Canvas do
      begin
        Brush.Color := clRed;
      end;
    For i := 0 to (Level - 1) do
      begin
        with Form1.Canvas do
          begin
            Rectangle(CoordX[i] - scale, CoordY[i] - scale, CoordX[i] + scale, CoordY[i] + scale);
            FloodFill(CoordX[i], CoordY[i], clRed, fsSurface);
          end;
      end;
  end;

Procedure TSnake.Defeat;
  begin
    Form1.Timer.Enabled := False;
    Sleep(1000);
    SetLength(CoordX, Snake.Level);
    SetLength(CoordY, Snake.level);
    First := true;
    Form1.PauseLabel.Visible := true;
    Counter := 0;
    Form1.Score01.Caption := 'Score: ' + IntTostr(Counter);
    Snake.Reboot;
    Food.Respawn;
  end;

Procedure TFood.Render;
  const
    scale = 5;
  begin
    with Form1.Canvas do
      begin
        Brush.Color := Color;
        Rectangle(FX - scale, FY - scale, FX + scale, FY + scale);
        FloodFill(FX, FY, clRed, fsSurface);
      end;
  end;

Procedure TSnake.Reboot;
  const
    speed = 10;
  begin
    Level := 1;
    SetLength(CoordX, Snake.Level);
    SetLength(CoordY, Snake.Level);
    CoordX[0] := Form1.ClientWidth div 2;
    CoordY[0] := Form1.ClientWidth div 2;
    VectX := 0;
    VectY := -speed;
  end;

procedure TFood.Respawn;{?}
  const
    scale = 10;
  var
    j: integer;
  begin
    j := Random((Form1.ClientWidth div scale) - 2) + 1;
    FX := scale * j;
    j := Random((Form1.ClientHeight div scale) - 2) + 1;
    FY := scale * j;
    j := Random(10) + 1;
    case j of
      1,2,3,4,5:
        begin
          Color := clGreen;
          Level := 1;
        end;
      6,7,8:
        begin
          Color := clBlue;
          Level := 2;
        end;
      9,10:
        begin
          Color := clYellow;
          Level := 3;
        end;
    end;
  end;

procedure TForm1.FormCreate(Sender: TObject);
  begin
    randomize;
    DoubleBuffered := True;
    Canvas.Pen.Width := 2;
    Canvas.Pen.Color := clBlack;
    Form1.Color := clBlack;
    Snake := TSnake.create;
    Food := TFood.create;
    ClientWidth := 300;
    ClientHeight := 300;
    Food.Respawn;
  end;

procedure TForm1.Exit1Click(Sender: TObject);
  begin
    Timer.Enabled := False;
    Snake.Free;
    Food.Free;
    close;
  end;

procedure TForm1.FormPaint(Sender: TObject);
  begin
    Snake.Move;
    Snake.Render;
    Food.Render;
  end;

procedure TForm1.TimerTimer(Sender: TObject);
  begin
    Form1.Repaint;
  end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
  const
    speed = 10;
  begin
    if First = True
      then
        GameStart
      else
        begin
          case Key of
            'w':
              begin
                if (Snake.VectY = 0) then
                  Snake.ChangeMove(0, -speed);
              end;
            's':
              begin
                if (Snake.VectY = 0) then
                  Snake.ChangeMove(0, speed);
              end;
            'a':
              begin
                if (Snake.VectX = 0) then
                  Snake.ChangeMove(-speed, 0);
              end;
            'd':
              begin
                if (Snake.VectX = 0) then
                  Snake.ChangeMove(speed, 0);
              end;
            '?':
              begin
                if (Snake.VectY = 0) then
                  Snake.ChangeMove(0, -speed);
              end;
            '?':
              begin
                if (Snake.VectY = 0) then
                  Snake.ChangeMove(0, speed);
              end;
            '?':
              begin
                if (Snake.VectX = 0) then
                  Snake.ChangeMove(-speed, 0);
              end;
            '?':
              begin
                if (Snake.VectX = 0) then
                  Snake.ChangeMove(speed, 0);
              end;
            chr(8):
              begin
                close;
              end;
            end;
        end;
  end;

procedure TForm1.ConsoleDebug1Click(Sender: TObject);
  begin
    if (not Assigned(DebugConsole))
      then
        DebugConsole := TDebugConsole.Create(Self);
    DebugConsole.Show;
    DebugCall := True;
  end;

procedure TForm1.TimerAdvTimer(Sender: TObject);
  begin
    TimerAdv.Enabled := False;
  end;

end.
