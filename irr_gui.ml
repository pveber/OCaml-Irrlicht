type obj = Irr_base.obj

(******************************************************************************)

(* Binding for class ICursorControl *)

(******************************************************************************)

external cursor_get_position : obj -> int Irr_core.pos_2d =
  "ml_ICursorControl_getPosition"

external cursor_get_relative_position : obj -> float Irr_core.pos_2d =
  "ml_ICursorControl_getRelativePosition"

external cursor_set_visible : obj -> bool -> unit =
  "ml_ICursorControl_setVisible"

class cursor obj = object(self)
  inherit Irr_base.reference_counted obj
  method pos = cursor_get_position self#obj
  method rel_pos = cursor_get_relative_position self#obj
  method set_visible b = cursor_set_visible self#obj b
end

(******************************************************************************)

(* Binding for class IGUIFont *)

(******************************************************************************)

external font_draw :
  obj -> string -> int Irr_core.rect -> int Irr_core.color -> bool -> bool ->
    (int Irr_core.rect) option -> unit =
      "ml_IGUIFont_draw_bytecode"
      "ml_IGUIFont_draw_native"

external font_get_dimension :
  obj -> string -> int Irr_core.dimension_2d = "ml_IGUIFont_getDimension"


class font obj = object(self)
  inherit Irr_base.reference_counted obj
  method draw text pos ?(hcenter = false) ?(vcenter = false) ?clip color =
    font_draw self#obj text pos color hcenter vcenter clip
  method get_dimension text = 
    font_get_dimension self#obj text
end

(******************************************************************************)

(* Binding for class IGUIElement *)

(******************************************************************************)

class element obj = object(self)
  inherit Irr_base.attribute_exchanging_object obj
  inherit Irr_base.event_receiver obj
end

(******************************************************************************)

(* Binding for class IGUIStaticText *)

(******************************************************************************)

external static_text_set_override_color : obj -> int Irr_core.color -> unit =
  "ml_IGUIStaticText_setOverrideColor"

class static_text obj = object(self)
  inherit element obj
  method set_override_color c = static_text_set_override_color self#obj c
end

(******************************************************************************)

(* Binding for class IGUIImage *)

(******************************************************************************)

class image obj = object(self)
  inherit element obj
end

(******************************************************************************)

(* Binding for class IGUISkin *)

(******************************************************************************)

external skin_set_font : obj -> obj -> Irr_enums.gui_default_font -> unit =
  "ml_IGUISkin_setFont"

external skin_get_color : obj -> Irr_enums.gui_default_color -> int Irr_core.color =
  "ml_IGUISkin_getColor"

external get_gui_default_color_count : unit -> int = "ml_get_EGDC_COUNT"

external default_color_of_int : int -> Irr_enums.gui_default_color =
  "ml_gui_default_color_of_int"

external skin_set_color :
  obj -> Irr_enums.gui_default_color -> int Irr_core.color -> unit =
    "ml_IGUISkin_setColor"

let default_color_count = get_gui_default_color_count ()

class skin obj = object(self)
  inherit Irr_base.attribute_exchanging_object obj
  method set_font ?(which = `default) (font : font) =
    skin_set_font self#obj font#obj which
  method color which = skin_get_color self#obj which
  method set_color which c = skin_set_color self#obj which c
end

(******************************************************************************)

(* Binding for class IGUIButton *)

(******************************************************************************)

class button obj = object(self)
  inherit element obj
end

(******************************************************************************)

(* Binding for class IGUIContextMenu *)

(******************************************************************************)

external context_menu_add_item : obj -> string -> int ->
  bool -> bool -> bool -> bool -> int =
  "ml_IGUIContextMenu_addItem_bytecode"
  "ml_IGUIContextMenu_addItem_native"

external context_menu_add_separator : obj -> unit =
  "ml_IGUIContextMenu_addSeparator"

external context_menu_set_close_handling :
  obj -> Irr_enums.context_menu_close -> unit =
  "ml_IGUIContextMenu_setCloseHandling"

class context_menu obj = object(self)
  inherit element obj
  method add_item ?(command_id=(-1)) ?(enabled=true) ?(has_submenu=false)
    ?(checked=false) ?(auto_checking=false) text =
    context_menu_add_item self#obj text command_id enabled has_submenu
      checked auto_checking
  method add_separator = context_menu_add_separator self#obj
  method set_close_handling on_close =
    context_menu_set_close_handling self#obj on_close
end

(******************************************************************************)

(* Binding for class IGUIScrollBar *)

(******************************************************************************)

external scroll_bar_set_max : obj -> int -> unit =
  "ml_IGUIScrollBar_setMax"

external scroll_bar_set_pos : obj -> int -> unit =
  "ml_IGUIScrollBar_setPos"

external scroll_bar_get_pos : obj -> int = "ml_IGUIScrollBar_getPos"

class scroll_bar obj = object(self)
  inherit element obj
  method set_max n = scroll_bar_set_max self#obj n
  method set_pos n = scroll_bar_set_pos self#obj n
  method pos = scroll_bar_get_pos self#obj
end

(******************************************************************************)

(* Binding for class IGUIListBox *)

(******************************************************************************)

external list_box_add_item : obj -> string -> int -> int =
  "ml_IGUIListBox_addItem"

class list_box obj = object(self)
  inherit element obj
  method add_item ?(icon = -1) text = list_box_add_item self#obj text icon
end

(******************************************************************************)

(* Binding for class IGUIEditBox *)

(******************************************************************************)

class edit_box obj = object(self)
  inherit element obj
end

(******************************************************************************)

(* Binding for class IGUIWindow *)

(******************************************************************************)

class window obj = object(self)
  inherit element obj
end

(******************************************************************************)

(* Binding for class IGUIFileOpenDialog *)

(******************************************************************************)

class file_open_dialog obj = object(self)
  inherit element obj
end

(******************************************************************************)

(* Binding for class IGUIEnvironment *)

(******************************************************************************)

external environment_add_image :
  obj -> obj -> int Irr_core.pos_2d -> bool -> obj option -> int ->
    string option -> obj =
      "ml_IGUIEnvironment_addImage_bytecode"
      "ml_IGUIEnvironment_addImage_native"

external environment_add_static_text :
  obj -> string -> int Irr_core.rect -> bool -> bool -> obj option -> int ->
    bool -> obj =
      "ml_IGUIEnvironment_addStaticText_bytecode"
      "ml_IGUIEnvironment_addStaticText_native"

external environment_draw_all : obj -> unit =
  "ml_IGUIEnvironment_drawAll"

external environment_get_built_in_font : obj -> obj =
  "ml_IGUIEnvironment_getBuiltInFont"

external environment_get_font : obj -> string -> obj =
  "ml_IGUIEnvironment_getFont"

external environment_get_skin : obj -> obj =
  "ml_IGUIEnvironment_getSkin"

external environment_add_button :
  obj -> int Irr_core.rect -> obj option -> int -> string option ->
    string option -> obj
  =
    "ml_IGUIEnvironment_addButton_bytecode"
    "ml_IGUIEnvironment_addButton_native"

external environment_add_menu :
  obj -> obj option -> int -> obj =
    "ml_IGUIEnvironment_addMenu"

external environment_add_scroll_bar :
  obj -> bool -> int Irr_core.rect -> obj option -> int -> obj =
    "ml_IGUIEnvironment_addScrollBar"

external environment_add_list_box :
  obj -> int Irr_core.rect -> obj option -> int -> bool -> obj =
    "ml_IGUIEnvironment_addListBox"

external environment_add_edit_box :
  obj -> string -> int Irr_core.rect -> bool -> obj option -> int -> obj =
    "ml_IGUIEnvironment_addEditBox_bytecode"
    "ml_IGUIEnvironment_addEditBox_native"

external environment_add_window :
  obj -> int Irr_core.rect -> bool -> string option -> obj option -> int -> obj
  =
    "ml_IGUIEnvironment_addWindow_bytecode"
    "ml_IGUIEnvironment_addWindow_native"

external environment_add_file_open_dialog :
  obj -> string option -> bool -> obj option -> int -> obj =
    "ml_IGUIEnvironment_addFileOpenDialog"

class environment obj = object(self)
  inherit Irr_base.reference_counted obj
  method built_in_font =
    let obj = environment_get_built_in_font self#obj in
    object
      val env = self
      inherit font obj
    end
  method font filename =
    let obj = environment_get_font self#obj filename in
    object
      val env = self
      inherit font obj
    end
  method skin =
    let obj = environment_get_skin self#obj in
    object
      val env = self
      inherit skin obj
    end
  method add_image (image : Irr_video.texture) ?(use_alpha = true) ?parent
    ?(id = -1) ?text pos =
    let p = match parent with
    | None -> None
    | Some (x : element) -> Some x#obj in
    let obj =
      environment_add_image self#obj image#obj pos use_alpha p id text in
    object
      val env = self
      inherit image obj
    end
  method add_static_text text ?(border = false) ?(word_wrap = true) ?parent
    ?(id = -1) ?(fill_bg = false) rect =
    let p = match parent with
    | None -> None
    | Some (x : element) -> Some x#obj in
    let obj =
      environment_add_static_text self#obj text rect border word_wrap p id
      fill_bg in
    object
      val env = self
      inherit static_text obj
    end
  method add_button ?parent ?(id = -1) ?text ?tooltiptext rect =
    let p = match parent with Some (x : element) -> Some x#obj | None -> None in
    let obj = environment_add_button self#obj rect p id text tooltiptext in
    object
      val env = self
      inherit button obj
    end
  method add_menu ?parent ?(id = -1) () =
    let p = match parent with Some (x : element) -> Some x#obj | None -> None in
    let obj = environment_add_menu self#obj p id in
    object
      val env = self
      inherit context_menu obj
    end
  method add_scroll_bar h ?parent ?(id = -1) rect =
    let p = match parent with Some (x : element) -> Some x#obj | None -> None in
    let obj = environment_add_scroll_bar self#obj h rect p id in
    object
      val env = self
      inherit scroll_bar obj
    end
  method add_list_box ?parent ?(id = -1) ?(draw_bg = false) rect =
    let p = match parent with Some (x : element) -> Some x#obj | None -> None in
    let obj = environment_add_list_box self#obj rect p id draw_bg in
    object
      val env = self
      inherit list_box obj
    end
  method add_edit_box text ?(border = true) ?parent ?(id = -1) rect =
    let p = match parent with Some (x : element) -> Some x#obj | None -> None in
    let obj = environment_add_edit_box self#obj text rect border p id in
    object
      val env = self
      inherit edit_box obj
    end
  method add_window ?(modal = false) ?text ?parent ?(id = -1) rect =
    let p = match parent with Some (x : element) -> Some x#obj | None -> None in
    let obj = environment_add_window self#obj rect modal text p id in
    object
      val env = self
      inherit window obj
    end
  method add_file_open_dialog ?title ?(modal = true) ?parent ?(id = -1) () =
    let p = match parent with Some (x : element) -> Some x#obj | None -> None in
    let obj = environment_add_file_open_dialog self#obj title modal p id in
    object
      val env = self
      inherit file_open_dialog obj
    end
  method draw_all = environment_draw_all self#obj
end
