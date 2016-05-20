# TODO

* Tests.
* Smart & fast redraw algorithm.
* Clipping & Z order.
* Double buffering? Or will this be handled by the adapters?
* Event::Propagator? Right now, `Event::Handler#delegate_event` does this but look how much it has to know about it's `host`.  
* Event consumption configuration.
* * The event stops propagating automatically (because some component handles it) or manual (keeps going unless explicitly stopped).
* * Automatic by default, but should be able to be set to manual.
* Right now, events propagate up the tree from the target to the root (bubbling).  
* * W3C defines propagation as going down from the root to the target (capturing) first, then back up from the target to the root.
* * See: http://www.w3.org/TR/DOM-Level-3-Events/#h3_event-flow
* * See: http://www.quirksmode.org/js/events_order.html
* Better adapter system.
* Threaded event loop and event queue and threaded handlers.
* Always update, only draw when needed (backing data has changed, a character needs to be draw, cursor needs to move...) Not the same as polling for events. This means a `#redraw?` hook.
* Margins and padding on ANY component. Doesn't work on listboxes, groups, etc.
* Automatic dimensions are acting weird. Project search for `:auto`.
* Label/textbox ellipsis when text width is longer than the label/textbox (optional).
* Autofocus attribute on focusable components.
* Textbox `placeholder` (says "Email" when there is no text, should be stylable based on it's state).
* Textbox `max_length`.
* Attribute inheritence with `:inherit`. Default on background, foreground, and other stylistic attributes.
* `border.left.size`, `border.right.color` etc.
* Split attributes in key with dashes so `margin-left: 10` breaks out to `margin: { left: 10 }`.
* Component dimension attribute arguments, by default returns it's width, with `width(:border, :margin, :padding)` it'd return the width plus it's offsets.
* * Remove `Component#outer_*`.
* Offsets shouldn't ignore padding as it does now.
* `Selected` event should just be `Select` (`Focus` isn't `Focused`).
* `#update?` hook.
* * Instead of running `#update` on all items on each cycle, it should only do that once when started.
* * When an event is handled by a component, it should update it and it's parents after all events have executed
* * Overwrite to return `true` to update every tick.
* Textbox moving cursor around.
* `contains_coordinates` tests because I'm sure this is borked.
* Use middleware for event propagation?
* Application structure documents
* Events are not inherited by component subclasses
Cura XML specification (CXML) XML extension, converts into Cura AST and CCML.

```
<?xml version="1.0"?>

<window name="main_window" title="My App">
  <label text="Hello world!" margin-bottom="10px" font-size="12px"/>
  <label text="This is my app!" margin-bottom="20px" />
  <textbox name="input_textbox" />
  <pack>
    <textbox name="another_textbox" />
  </pack>
</window>
```

Cura Component Markup Language specification (CCML), converts into Cura AST and CXML.

```
window@main_window(title="My App")
  label(text="Hello world!" margin-bottom="10px" font-size="12px")
  label(text="This is my app!" margin-bottom="20px")
  textbox@input_textbox
  pack@textbox_pack(class="TextboxPack")
    textbox@another_textbox
```

Both are the same as:

```
class TextboxPack < Cura::Component::Pack
  def initialize(attributes={})
    @another_textbox = add_child(:textbox)

    super
  end

  attr_reader :another_textbox
end

class Window1 < Cura::Window
  def initialize(attributes={})
    add_child(:label, text: "Hello world!", margin-bottom: 10, font-size: 12)
    add_child(:label, text: "This is my app!", margin-bottom: 20)

    @input_textbox = add_child(:textbox)
    @textbox_pack = add_child(TextboxPack.new)

    super
  end

  attr_reader :input_textbox
  attr_reader :textbox_pack
end

class Application < Cura::Application
  def initialize(attributes={})
    @window = add_window(Window1.new(title: "My App"))

    super
  end

  attr_reader :window
end
```

* ASTTransformer which transforms Cura AST into a Cura Component view tree.
* Ability to use CSS so document structure and presentation are separate.
* * CSS can be applied to any XML.

```
#main_window {
  width: 500px;
}

#main_window label:first-child {
  margin-bottom: 10px;
}
```

* Hide/show components.
* Find by id
* Allow `#add_window` to accept a Hash and create a new window instance line `#add_child`.
* `Menu`, `MenuItem`, etc.
* `Menu` opening slope.
* * When the mouse is moved within the triangle area with points at the mouse, the top-left submenu corner and the bottom-left submenu corner, then it should keep the submenu open.
    http://bjk5.com/post/44698559168/breaking-down-amazons-mega-dropdown
    https://github.com/kamens/jQuery-menu-aim/blob/master/jquery.menu-aim.js#L198-L307
* Focusing doesn't update `FocusController` index.
* Event string matching


```
on_event(:key_down) do |event|
  return unless event.target == self

  go_forward unless event.match?("control-f")
  go_back unless event.match?("control-B")
  go_home unless event.match?("control-h")
  open_favorites unless event.match?("shift-control-f")
  open_history unless event.match?("COntROl-shft-h")
  open_inventory unless event.match?("^-I")
  open_index unless event.match?("^-shift-i")
end
```
