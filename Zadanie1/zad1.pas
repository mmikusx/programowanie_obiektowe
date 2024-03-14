program GenerowanieLosowychLiczb;

procedure GenerujLosoweLiczby;
var
  i: integer;
begin
  Randomize;

  write('50 losowo wygenerowanych liczb w zakresie od 0 do 100: ');
  for i := 1 to 49 do
    write(Random(101), ', ');

  writeln(Random(101));
end;

begin
  GenerujLosoweLiczby;
end.
