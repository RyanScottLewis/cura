* Tests
* See if XUL (or HTML... why not?) can be used as document structure, if not:
* * CCML Cura Component Markup Language specification (CCML). XML extension?
* * Parser which parses CCML into Cura Component AST (CC-AST)
* * TreeTransformer which transforms CC-AST into a Cura Component Tree
* Ability to use CSS so document structure and presentation are separate
* Smart & fast redraw aglorithm
* Clipping & Z order
* Double buffering? Or will this be handled by the adapters?
* Event translator. Before dispatching events (or before they are added to the queue?), see if they can be translated into 
  higher-level events such as a MouseDown then a MouseUp could translate to a MouseClick.  
  Have this be optional per Component.
* Event loop separation? Maybe Event::Loop? See Application.run
* Event::Propagator? Right now, Event::Handler#delegate_event does this but look how much it has to know about it's `host`.  
  It would be better to be able to `host.propagate_event(event)` rather than `host.parent.event_handler.handle(event) if ...`
* Event "consumption" configuration.  
  The event stops propagating automatically (because some component handles it) or manual (keeps going unless explicitly stopped).
  Automatic by default, but should be able to be set to manual.
* RIght now, events propagate up the tree from the target to the root (bubbling).  
  W3C defines propagation as going down from the root to the target (capturing) first, then 
  back up from the target to the root. http://www.w3.org/TR/DOM-Level-3-Events/#h3_event-flow
* Todo example application
* Better adapter system.
* Threaded event loop
* Always update, only draw when needed (backing data has changed, a character needs to be draw, cursor needs to move...)
* Margins and padding on ANY component. Doesn't work on listboxes, groups, etcetc
* Listbox children should be able to have an arbitrary object be associated with it.