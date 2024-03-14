program GenerowanieOrazSortowanieTablicy;

const
  N = 50;

procedure GenerujOrazSortujLiczby;
var
  liczby: array[1..N] of integer;
  i, j, temp: integer;
begin
  Randomize;

  for i := 1 to N do
    liczby[i] := Random(101);

  for i := 1 to N - 1 do
    for j := 1 to N - i do
      if liczby[j] > liczby[j + 1] then
      begin
        temp := liczby[j];
        liczby[j] := liczby[j + 1];
        liczby[j + 1] := temp;
      end;

  writeln('Wygenerowane i posortowane liczby rosnąco:');
  write('[ ');
  for i := 1 to N - 1 do
    write(liczby[i], ', ');
  writeln(liczby[N], ' ]');
end;

begin
  GenerujOrazSortujLiczby;
end.
