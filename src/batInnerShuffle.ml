let array_shuffle ?state a =
  let random_int state n = match state with
    | None -> Random.int n
    | Some s -> Random.State.int s n in
  for n = Array.length a - 1 downto 1 do
    let k = random_int state (n + 1) in
    if k <> n then begin
      let buf = Array.unsafe_get a n in
      Array.unsafe_set a n (Array.unsafe_get a k);
      Array.unsafe_set a k buf
    end
  done

(*$Q
  Q.(array_of_size Gen.(2--15) small_int) (fun a -> \
    let a' = Array.copy a in \
    array_shuffle a'; \
    (Array.to_list a' |> List.sort Pervasives.compare) = \
     (Array.to_list a |> List.sort Pervasives.compare))
*)
