# TODO

* Tests !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* See if XUL (or HTML... why not?) can be used as document structure, if not:
* * CCML Cura Component Markup Language specification (CCML). XML extension?
* * Parser which parses CCML into Cura Component AST (CC-AST)
* * TreeTransformer which transforms CC-AST into a Cura Component Tree
* Ability to use CSS so document structure and presentation are separate
* Smart & fast redraw aglorithm
* Clipping & Z order
* Double buffering? Or will this be handled by the adapters?
* Event translator. Before dispatching events (or before they are added to the queue?), see if they can be translated into higher-level events such as a MouseDown then a MouseUp could translate to a MouseClick.  
* * Have this be optional per Component.
* Event::Propagator? Right now, Event::Handler#delegate_event does this but look how much it has to know about it's `host`.  
* Event "consumption" configuration.
* * The event stops propagating automatically (because some component handles it) or manual (keeps going unless explicitly stopped).
* * Automatic by default, but should be able to be set to manual.
* Right now, events propagate up the tree from the target to the root (bubbling).  
* * W3C defines propagation as going down from the root to the target (capturing) first, then back up from the target to the root. http://www.w3.org/TR/DOM-Level-3-Events/#h3_event-flow
* Better adapter system.
* Threaded event loop and event queue and threaded handlers
* Always update, only draw when needed (backing data has changed, a character needs to be draw, cursor needs to move...)
* Margins and padding on ANY component. Doesn't work on listboxes, groups, etcetc
* Automatic dimensions are acting weird. Project search for ":auto"
* Label/textbox ellipsis when text width is longer than the label/textbox (optional and default)
* Autofocus attribute on focusable components
* Textbox placeholder (says "Email" when there is no text, should be styleable based on it's state)
* Textbox max_length
* Attribute inheritence with :inherit. Default on background, foreground, and other stylistic attributes
* border.left.size, border.right.color
* Split attributes in key with dashes so margin-left: 10 breaks out to margin: { left: 10 }
* Component dimension attribute arguments, by default return's it's width, with `width(:border, :margin, :padding)` it'd return the width plus it's offsets
* * Remove Component#outer_*
* Offsets shouldn't ignore padding as it does now
* Selected event should just be Select (Focus isn't "Focused")
* Instead of running #update on all items on each cycle, it should only do that once when started
* * When an event is handled by a component, it should update it and it's parents after all events have executed
* Textbox moving cursor around
* Hide/show components

# Current Issues
* typing in textboxes is offset by 1
