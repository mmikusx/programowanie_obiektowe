program GenerowanieOrazSortowanieTablicy;

const
  MAX_N = 200;

procedure GenerujOrazSortujLiczby(od, do_: integer; ile: integer);
var
  liczby: array[1..MAX_N] of integer;
  i, j, temp: integer;
begin
  if ile > MAX_N then
  begin
    writeln(Przekroczono maksymalną liczbę generowanych liczb.');
    Exit;
  end;
  
  Randomize;

  for i := 1 to ile do
    liczby[i] := Random(do_ - od + 1) + od;

  for i := 1 to ile - 1 do
    for j := 1 to ile - i do
      if liczby[j] > liczby[j + 1] then
      begin
        temp := liczby[j];
        liczby[j] := liczby[j + 1];
        liczby[j + 1] := temp;
      end;

  writeln('Wygenerowane i posortowane liczby rosnąco:');
  write('[ ');
  for i := 1 to ile - 1 do
    write(liczby[i], ', ');
  writeln(liczby[ile], ' ]');
end;

begin
  GenerujOrazSortujLiczby(1, 100, 20);
end.
