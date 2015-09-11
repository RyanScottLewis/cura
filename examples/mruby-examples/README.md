To run the examples, clone MRuby and add the following to the `default.gembox`:

```rb
conf.gem github: 'iij/mruby-regexp-pcre' # Dependency of cura (in MRuby)

conf.gem github: 'RyanScottLewis/cura'

conf.gem github: 'RyanScottLewis/mruby-termbox' # Dependency of mruby-cura-termbox
conf.gem github: 'RyanScottLewis/mruby-cura-termbox'

conf.gem 'path_to/cura/examples/mruby-examples'
```
