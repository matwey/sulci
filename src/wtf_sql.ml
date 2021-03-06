(* DO NOT EDIT MANUALLY *)
(*  *)
(* generated by sqlgg 0.2.3-49-g30df037 on 2010-01-14T17:45Z *)

module Make (T : Sqlgg_traits.M) = struct

  let create_wtf db  =
    T.execute db "CREATE TABLE IF NOT EXISTS wtf (stamp int, nick varchar, luser varchar, lserver varchar, \"key\" varchar, \"value\" varchar)" T.no_params 

  let create_index_dfnidx db  =
    T.execute db "CREATE INDEX IF NOT EXISTS dfnidx ON wtf (\"key\")" T.no_params 

  let create_index_dfncheck db  =
    T.execute db "CREATE INDEX IF NOT EXISTS dfncheck ON wtf (\"key\", luser, lserver)" T.no_params 

  let total db  =
    let get_row stmt =
      (T.get_column_Int stmt 0)
    in
    T.select1 db "SELECT COUNT(*) FROM wtf" T.no_params get_row

  let dfn_new db ~stamp ~nick ~luser ~lserver ~key ~value =
    let set_params stmt =
      let p = T.start_params stmt 6 in
      T.set_param_Int p 0 stamp;
      T.set_param_Text p 1 nick;
      T.set_param_Text p 2 luser;
      T.set_param_Text p 3 lserver;
      T.set_param_Text p 4 key;
      T.set_param_Text p 5 value;
      T.finish_params p
    in
    T.execute db "INSERT INTO wtf (stamp, nick, luser, lserver, \"key\", \"value\") VALUES (@stamp,@nick,@luser,@lserver,@key,@value)" set_params 

  let dfn_check_by_jid db ~key ~luser ~lserver =
    let get_row stmt =
      (T.get_column_Text stmt 0)
    in
    let set_params stmt =
      let p = T.start_params stmt 3 in
      T.set_param_Text p 0 key;
      T.set_param_Text p 1 luser;
      T.set_param_Text p 2 lserver;
      T.finish_params p
    in
    T.select1 db "SELECT \"value\" FROM wtf WHERE \"key\"=@key AND luser=@luser AND lserver=@lserver LIMIT 1" set_params get_row

  let dfn_delete_by_jid db ~key ~luser ~lserver =
    let set_params stmt =
      let p = T.start_params stmt 3 in
      T.set_param_Text p 0 key;
      T.set_param_Text p 1 luser;
      T.set_param_Text p 2 lserver;
      T.finish_params p
    in
    T.execute db "DELETE FROM wtf WHERE \"key\"=@key AND luser=@luser AND lserver=@lserver" set_params 

  let dfn_update_by_jid db ~stamp ~nick ~value ~key ~luser ~lserver =
    let set_params stmt =
      let p = T.start_params stmt 6 in
      T.set_param_Int p 0 stamp;
      T.set_param_Text p 1 nick;
      T.set_param_Text p 2 value;
      T.set_param_Text p 3 key;
      T.set_param_Text p 4 luser;
      T.set_param_Text p 5 lserver;
      T.finish_params p
    in
    T.execute db "UPDATE wtf SET stamp=@stamp, nick=@nick, \"value\"=@value WHERE \"key\"=@key AND luser=@luser AND lserver=@lserver" set_params 

  let dfn_check_by_occupant db ~key ~nick ~luser ~lserver =
    let get_row stmt =
      (T.get_column_Text stmt 0)
    in
    let set_params stmt =
      let p = T.start_params stmt 4 in
      T.set_param_Text p 0 key;
      T.set_param_Text p 1 nick;
      T.set_param_Text p 2 luser;
      T.set_param_Text p 3 lserver;
      T.finish_params p
    in
    T.select1 db "SELECT \"value\" FROM wtf WHERE \"key\"=@key AND nick=@nick AND luser=@luser AND lserver=@lserver LIMIT 1" set_params get_row

  let dfn_delete_by_occupant db ~key ~nick ~luser ~lserver =
    let set_params stmt =
      let p = T.start_params stmt 4 in
      T.set_param_Text p 0 key;
      T.set_param_Text p 1 nick;
      T.set_param_Text p 2 luser;
      T.set_param_Text p 3 lserver;
      T.finish_params p
    in
    T.execute db "DELETE FROM wtf WHERE \"key\"=@key AND nick=@nick AND luser=@luser AND lserver=@lserver" set_params 

  let dfn_update_by_occupant db ~stamp ~value ~key ~nick ~luser ~lserver =
    let set_params stmt =
      let p = T.start_params stmt 6 in
      T.set_param_Int p 0 stamp;
      T.set_param_Text p 1 value;
      T.set_param_Text p 2 key;
      T.set_param_Text p 3 nick;
      T.set_param_Text p 4 luser;
      T.set_param_Text p 5 lserver;
      T.finish_params p
    in
    T.execute db "UPDATE wtf SET stamp=@stamp, \"value\"=@value WHERE \"key\"=@key AND nick=@nick AND luser=@luser AND lserver=@lserver" set_params 

  let get_wtf_one db ~key =
    let get_row stmt =
      (T.get_column_Text stmt 0), (T.get_column_Text stmt 1)
    in
    let set_params stmt =
      let p = T.start_params stmt 1 in
      T.set_param_Text p 0 key;
      T.finish_params p
    in
    T.select1 db "SELECT nick, \"value\" FROM wtf WHERE \"key\"=@key ORDER BY stamp DESC LIMIT 1" set_params get_row

  let get_wtf_all db ~key callback =
    let invoke_callback stmt =
      callback
        (T.get_column_Text stmt 0)
        (T.get_column_Text stmt 1)
        (T.get_column_Text stmt 2)
    in
    let set_params stmt =
      let p = T.start_params stmt 1 in
      T.set_param_Text p 0 key;
      T.finish_params p
    in
    T.select db "SELECT nick, \"key\", \"value\" FROM wtf WHERE \"key\"=@key ORDER BY stamp" set_params invoke_callback

  let wtf_count db ~key =
    let get_row stmt =
      (T.get_column_Int stmt 0)
    in
    let set_params stmt =
      let p = T.start_params stmt 1 in
      T.set_param_Text p 0 key;
      T.finish_params p
    in
    T.select1 db "SELECT count(*) FROM wtf WHERE \"key\"=@key" set_params get_row

  let wtffind db ~key ~value callback =
    let invoke_callback stmt =
      callback
        (T.get_column_Text stmt 0)
        (T.get_column_Text stmt 1)
        (T.get_column_Text stmt 2)
    in
    let set_params stmt =
      let p = T.start_params stmt 2 in
      T.set_param_Text p 0 key;
      T.set_param_Text p 1 value;
      T.finish_params p
    in
    T.select db "SELECT nick, \"key\", \"value\" FROM wtf WHERE \"key\" LIKE @key OR \"value\" LIKE @value" set_params invoke_callback

  let get_rand db ~rand =
    let get_row stmt =
      (T.get_column_Text stmt 0), (T.get_column_Text stmt 1), (T.get_column_Text stmt 2)
    in
    let set_params stmt =
      let p = T.start_params stmt 1 in
      T.set_param_Int p 0 rand;
      T.finish_params p
    in
    T.select1 db "SELECT nick, \"key\", \"value\" FROM wtf LIMIT @rand,1" set_params get_row

  let get_key_total db ~key =
    let get_row stmt =
      (T.get_column_Int stmt 0)
    in
    let set_params stmt =
      let p = T.start_params stmt 1 in
      T.set_param_Text p 0 key;
      T.finish_params p
    in
    T.select1 db "SELECT count(*) FROM wtf WHERE \"key\"=@key" set_params get_row

  let get_rand_key db ~key ~rand =
    let get_row stmt =
      (T.get_column_Text stmt 0), (T.get_column_Text stmt 1)
    in
    let set_params stmt =
      let p = T.start_params stmt 2 in
      T.set_param_Text p 0 key;
      T.set_param_Int p 1 rand;
      T.finish_params p
    in
    T.select1 db "SELECT nick, \"value\" FROM wtf WHERE \"key\"=@key LIMIT @rand,1" set_params get_row

  let delete_key db ~key =
    let set_params stmt =
      let p = T.start_params stmt 1 in
      T.set_param_Text p 0 key;
      T.finish_params p
    in
    T.execute db "DELETE FROM wtf WHERE \"key\"=@key" set_params 

  let delete_key_value db ~key ~value =
    let set_params stmt =
      let p = T.start_params stmt 2 in
      T.set_param_Text p 0 key;
      T.set_param_Text p 1 value;
      T.finish_params p
    in
    T.execute db "DELETE FROM wtf WHERE \"key\"=@key AND \"value\"=@value" set_params 

  module Fold = struct
    let create_wtf db  =
      T.execute db "CREATE TABLE IF NOT EXISTS wtf (stamp int, nick varchar, luser varchar, lserver varchar, \"key\" varchar, \"value\" varchar)" T.no_params 

    let create_index_dfnidx db  =
      T.execute db "CREATE INDEX IF NOT EXISTS dfnidx ON wtf (\"key\")" T.no_params 

    let create_index_dfncheck db  =
      T.execute db "CREATE INDEX IF NOT EXISTS dfncheck ON wtf (\"key\", luser, lserver)" T.no_params 

    let total db  =
      let get_row stmt =
        (T.get_column_Int stmt 0)
      in
      T.select1 db "SELECT COUNT(*) FROM wtf" T.no_params get_row

    let dfn_new db ~stamp ~nick ~luser ~lserver ~key ~value =
      let set_params stmt =
        let p = T.start_params stmt 6 in
        T.set_param_Int p 0 stamp;
        T.set_param_Text p 1 nick;
        T.set_param_Text p 2 luser;
        T.set_param_Text p 3 lserver;
        T.set_param_Text p 4 key;
        T.set_param_Text p 5 value;
        T.finish_params p
      in
      T.execute db "INSERT INTO wtf (stamp, nick, luser, lserver, \"key\", \"value\") VALUES (@stamp,@nick,@luser,@lserver,@key,@value)" set_params 

    let dfn_check_by_jid db ~key ~luser ~lserver =
      let get_row stmt =
        (T.get_column_Text stmt 0)
      in
      let set_params stmt =
        let p = T.start_params stmt 3 in
        T.set_param_Text p 0 key;
        T.set_param_Text p 1 luser;
        T.set_param_Text p 2 lserver;
        T.finish_params p
      in
      T.select1 db "SELECT \"value\" FROM wtf WHERE \"key\"=@key AND luser=@luser AND lserver=@lserver LIMIT 1" set_params get_row

    let dfn_delete_by_jid db ~key ~luser ~lserver =
      let set_params stmt =
        let p = T.start_params stmt 3 in
        T.set_param_Text p 0 key;
        T.set_param_Text p 1 luser;
        T.set_param_Text p 2 lserver;
        T.finish_params p
      in
      T.execute db "DELETE FROM wtf WHERE \"key\"=@key AND luser=@luser AND lserver=@lserver" set_params 

    let dfn_update_by_jid db ~stamp ~nick ~value ~key ~luser ~lserver =
      let set_params stmt =
        let p = T.start_params stmt 6 in
        T.set_param_Int p 0 stamp;
        T.set_param_Text p 1 nick;
        T.set_param_Text p 2 value;
        T.set_param_Text p 3 key;
        T.set_param_Text p 4 luser;
        T.set_param_Text p 5 lserver;
        T.finish_params p
      in
      T.execute db "UPDATE wtf SET stamp=@stamp, nick=@nick, \"value\"=@value WHERE \"key\"=@key AND luser=@luser AND lserver=@lserver" set_params 

    let dfn_check_by_occupant db ~key ~nick ~luser ~lserver =
      let get_row stmt =
        (T.get_column_Text stmt 0)
      in
      let set_params stmt =
        let p = T.start_params stmt 4 in
        T.set_param_Text p 0 key;
        T.set_param_Text p 1 nick;
        T.set_param_Text p 2 luser;
        T.set_param_Text p 3 lserver;
        T.finish_params p
      in
      T.select1 db "SELECT \"value\" FROM wtf WHERE \"key\"=@key AND nick=@nick AND luser=@luser AND lserver=@lserver LIMIT 1" set_params get_row

    let dfn_delete_by_occupant db ~key ~nick ~luser ~lserver =
      let set_params stmt =
        let p = T.start_params stmt 4 in
        T.set_param_Text p 0 key;
        T.set_param_Text p 1 nick;
        T.set_param_Text p 2 luser;
        T.set_param_Text p 3 lserver;
        T.finish_params p
      in
      T.execute db "DELETE FROM wtf WHERE \"key\"=@key AND nick=@nick AND luser=@luser AND lserver=@lserver" set_params 

    let dfn_update_by_occupant db ~stamp ~value ~key ~nick ~luser ~lserver =
      let set_params stmt =
        let p = T.start_params stmt 6 in
        T.set_param_Int p 0 stamp;
        T.set_param_Text p 1 value;
        T.set_param_Text p 2 key;
        T.set_param_Text p 3 nick;
        T.set_param_Text p 4 luser;
        T.set_param_Text p 5 lserver;
        T.finish_params p
      in
      T.execute db "UPDATE wtf SET stamp=@stamp, \"value\"=@value WHERE \"key\"=@key AND nick=@nick AND luser=@luser AND lserver=@lserver" set_params 

    let get_wtf_one db ~key =
      let get_row stmt =
        (T.get_column_Text stmt 0), (T.get_column_Text stmt 1)
      in
      let set_params stmt =
        let p = T.start_params stmt 1 in
        T.set_param_Text p 0 key;
        T.finish_params p
      in
      T.select1 db "SELECT nick, \"value\" FROM wtf WHERE \"key\"=@key ORDER BY stamp DESC LIMIT 1" set_params get_row

    let get_wtf_all db ~key callback acc =
      let invoke_callback stmt =
        callback
          (T.get_column_Text stmt 0)
          (T.get_column_Text stmt 1)
          (T.get_column_Text stmt 2)
      in
      let set_params stmt =
        let p = T.start_params stmt 1 in
        T.set_param_Text p 0 key;
        T.finish_params p
      in
      let r_acc = ref acc in
      T.select db "SELECT nick, \"key\", \"value\" FROM wtf WHERE \"key\"=@key ORDER BY stamp" set_params (fun x -> r_acc := invoke_callback x !r_acc);
      !r_acc

    let wtf_count db ~key =
      let get_row stmt =
        (T.get_column_Int stmt 0)
      in
      let set_params stmt =
        let p = T.start_params stmt 1 in
        T.set_param_Text p 0 key;
        T.finish_params p
      in
      T.select1 db "SELECT count(*) FROM wtf WHERE \"key\"=@key" set_params get_row

    let wtffind db ~key ~value callback acc =
      let invoke_callback stmt =
        callback
          (T.get_column_Text stmt 0)
          (T.get_column_Text stmt 1)
          (T.get_column_Text stmt 2)
      in
      let set_params stmt =
        let p = T.start_params stmt 2 in
        T.set_param_Text p 0 key;
        T.set_param_Text p 1 value;
        T.finish_params p
      in
      let r_acc = ref acc in
      T.select db "SELECT nick, \"key\", \"value\" FROM wtf WHERE \"key\" LIKE @key OR \"value\" LIKE @value" set_params (fun x -> r_acc := invoke_callback x !r_acc);
      !r_acc

    let get_rand db ~rand =
      let get_row stmt =
        (T.get_column_Text stmt 0), (T.get_column_Text stmt 1), (T.get_column_Text stmt 2)
      in
      let set_params stmt =
        let p = T.start_params stmt 1 in
        T.set_param_Int p 0 rand;
        T.finish_params p
      in
      T.select1 db "SELECT nick, \"key\", \"value\" FROM wtf LIMIT @rand,1" set_params get_row

    let get_key_total db ~key =
      let get_row stmt =
        (T.get_column_Int stmt 0)
      in
      let set_params stmt =
        let p = T.start_params stmt 1 in
        T.set_param_Text p 0 key;
        T.finish_params p
      in
      T.select1 db "SELECT count(*) FROM wtf WHERE \"key\"=@key" set_params get_row

    let get_rand_key db ~key ~rand =
      let get_row stmt =
        (T.get_column_Text stmt 0), (T.get_column_Text stmt 1)
      in
      let set_params stmt =
        let p = T.start_params stmt 2 in
        T.set_param_Text p 0 key;
        T.set_param_Int p 1 rand;
        T.finish_params p
      in
      T.select1 db "SELECT nick, \"value\" FROM wtf WHERE \"key\"=@key LIMIT @rand,1" set_params get_row

    let delete_key db ~key =
      let set_params stmt =
        let p = T.start_params stmt 1 in
        T.set_param_Text p 0 key;
        T.finish_params p
      in
      T.execute db "DELETE FROM wtf WHERE \"key\"=@key" set_params 

    let delete_key_value db ~key ~value =
      let set_params stmt =
        let p = T.start_params stmt 2 in
        T.set_param_Text p 0 key;
        T.set_param_Text p 1 value;
        T.finish_params p
      in
      T.execute db "DELETE FROM wtf WHERE \"key\"=@key AND \"value\"=@value" set_params 

  end (* module Fold *)
end (* module Make *)
