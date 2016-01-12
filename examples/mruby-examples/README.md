To run the examples, clone MRuby and add the following to the `mrbgems/default.gembox` file:

```rb
conf.gem github: 'RyanScottLewis/cura'

conf.gem github: 'RyanScottLewis/mruby-termbox' # Dependency of mruby-cura-termbox
conf.gem github: 'RyanScottLewis/mruby-cura-termbox'

conf.gem 'path_to/cura/examples/mruby-examples'
```
