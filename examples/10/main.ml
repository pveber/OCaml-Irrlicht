module Id : sig
  type t =
    Quit_button | New_window_button | File_open_button |
    Transparency_scroll_bar
  val of_int : int -> t option
  val to_int : t -> int
end = struct
  type t =
    Quit_button | New_window_button | File_open_button |
    Transparency_scroll_bar
  let assoc =
    [(Quit_button, 101); (New_window_button, 1); (File_open_button, 2);
    (Transparency_scroll_bar, 3)]
  let assoc_inv = List.map (fun (x, y) -> (y, x)) assoc
  let of_int i = try Some (List.assoc i assoc_inv) with Not_found -> None
  let to_int x = try List.assoc x assoc with Not_found -> assert false
end

let change_font (env : Irr_gui.environment) =
  let skin = env#skin in
  let font = env#font "../../media/fonthaettenschweiler.bmp" in
  skin#set_font font;
  skin#set_font ~which:`tooltip env#built_in_font

let add_buttons (env : Irr_gui.environment) =
  let _ = env#add_button ~text:"Quit" ~tooltiptext:"Exits program"
    ~id:(Id.to_int Id.Quit_button) (10, 240, 110, 240 + 32) in
  let _ = env#add_button ~text:"New window" ~tooltiptext:"Launches a new Window"
    ~id:(Id.to_int Id.New_window_button) (10, 280, 110, 280 + 32) in
  let _ = env#add_button ~text:"File open" ~tooltiptext:"Opens a file"
    ~id:(Id.to_int Id.File_open_button) (10, 320, 110, 320 + 32) in ()

let add_scroll_bar (env : Irr_gui.environment) =
  let _ = env#add_static_text "Transparent Control:"
    ~border:true (150, 20, 350, 40) in
  let scroll_bar = env#add_scroll_bar true
    ~id:(Id.to_int Id.Transparency_scroll_bar) (150, 45, 350, 60) in
  scroll_bar#set_max 255;
  scroll_bar#set_pos (env#skin#color `window).Irr_core.a;
  scroll_bar

let add_list_and_edit_box (env : Irr_gui.environment) =
  let _ = env#add_static_text "Logging ListBox" ~border:true
    (50, 110, 250, 130) in
  let list_box = env#add_list_box (50, 140, 250, 210) in
  let _ = env#add_edit_box "Editable Text" (350, 80, 550, 100) in
  list_box

let counter = ref 0

let new_window (env : Irr_gui.environment) (list_box : Irr_gui.list_box) =
  let _ = list_box#add_item "Window created" in
  counter := (!counter + 30) mod 200;
  let f x = x + !counter in
  let window = env#add_window ~text:"Test window" (f 100, f 100, f 300, f 200)
  in
  let _ = env#add_static_text "Please close me" ~border:true ~word_wrap:false
    ~parent:window (35, 35, 140, 50) in
  true

let open_file (env : Irr_gui.environment) (list_box : Irr_gui.list_box) =
  let _ = list_box#add_item "File open" in
  let _ = env#add_file_open_dialog ~title:"Please choose a file" () in
  true

let change_color (env : Irr_gui.environment) (scroll_bar : Irr_gui.scroll_bar) =
  let pos = scroll_bar#pos in
  for i = 0 to Irr_gui.default_color_count - 1 do
    let col = env#skin#color (Irr_gui.default_color_of_int i) in
    let col1 = {Irr_core.a = pos; r = col.Irr_core.r;
    g = col.Irr_core.g; b = col.Irr_core.b} in
    env#skin#set_color (Irr_gui.default_color_of_int i) col1
  done;
  true

let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver in
  let env = device#gui_env in
  change_font env;
  add_buttons env;
  let scroll_bar = add_scroll_bar env in
  let list_box = add_list_and_edit_box env in
  let on_event = function
    | `gui_event {Irr_base.ge_caller = id; ge_type = `button_clicked} ->
        (match Id.of_int id with
        | Some Id.Quit_button -> device#close; true
        | Some Id.New_window_button -> new_window env list_box            
        | Some Id.File_open_button -> open_file env list_box            
        | _ -> false)
    | `gui_event {Irr_base.ge_type = `scroll_bar_changed} ->
        change_color env scroll_bar
    | _ -> false in
  device#set_on_event on_event;
  let _ = env#add_image (driver#get_texture "../../media/irrlichtlogo2.png")
    (10, 10) in
  while device#run do
    if device#is_window_active then (
      driver#begin_scene ~color:(Irr_core.color_ARGB 0 200 200 200) ();
      env#draw_all;
      driver#end_scene
    );
  done
