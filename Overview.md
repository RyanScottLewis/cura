
Component
  View tree
    Each component has a parent and optionally children which create a hierarchy of components
  Attribute Inheritance
    Attributes can be inherited from it’s parents.
  Automatic Attributes
Events
  Dispatcher
    A single object polling for low level events
  Handler
    The controller that is attached to Components and listens for events
  Translator
    Translates low level events into higher level events. Should use state machines
  Propagation
    Event’s are transferred from it’s child to itself or from it’s parent to itself.
  Consuming
    Translating events optionally consume them and can be optionally consumed within handlers
  Queue
    Events are queued
  Loop
    Waits for events on the queue and performs translating and dispatching
  Phases
    Events propagate from the root to the target in a “capturing” phase, then hits the target with the “at-target” phase, then moves from the target to the root in a “bubbling” phase.
Output
  Drawing
    Pixel
      Cell by cell drawing, lowest level
    Stroke
      Drawing lines, text, boxes, filling, medium level
    Object
      Visual objects such as Text, Line, Rectangle, highest level
  Redraw
    When a young component needs to redraw, it queues itself for redrawing along with a bounding box of all that needs to redraw. Then when it actually happens, the bounding box is passed to all ancestors from the root to the target and that are within the bounding box is drawn for each component.
  Layout
    Each object’s coordinates are relative to it’s parent’s coordinates. Packing allows the parent to control it’s children’s coordinates and dimensions
Input
  Hit testing
    Mouse events are dispatched to the current component under the cursor.
  Keyboard Focus
    Keyboard events are dispatched to the current component with keyboard focus. Each window has it’s own “currently focused” component.
  Mouse capture
    Allow a component to capture all mouse events after a mouse event, such as when you click and drag. Keyboard focus equivalent for the mouse.


Model-View (MV) Pattern
  Cura uses the Model-View pattern where the “view" is a Component, which is view and controller merged into one object.

Esuna
  A framework using Cura and includes models, internationalization, formatting (for dates, currency, etc), external styling, logging
