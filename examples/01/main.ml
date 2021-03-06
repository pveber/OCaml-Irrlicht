let add_sydney (driver : Irr_video.driver) (smgr : Irr_scene.manager) =
  let mesh = smgr#get_mesh "../../media/sydney.md2" in
  let node = smgr#add_animated_mesh_node mesh in
  node#set_material_flag `lighting false;
  node#set_md2_animation `stand;
  node#set_material_texture (driver#get_texture "../../media/sydney.bmp")

let () =
  let device = Irr.create_device () in
  (*device#set_resizable false;*)
  device#set_window_caption "Hello world! - Irrlicht Engine Demo";
  let driver = device#driver in
  let smgr = device#scene_manager in
  let guienv = device#gui_env in
  let _ = guienv#add_static_text
    "Hello world! This is the Irrlicht Software renderer" ~border:true
    (10, 10, 260, 22) in
  add_sydney driver smgr;
  let _ = smgr#add_camera ~pos:(0., 30., -40.) ~lookat:(0., 5., 0.) () in
  while device#run do
    driver#begin_scene ~color:(Irr_core.color_ARGB 255 100 101 140) ();
    smgr#draw_all;
    guienv#draw_all;
    driver#end_scene
  done
