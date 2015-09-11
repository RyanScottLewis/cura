#include "mruby.h"
#include "mruby/variable.h"

int run_example_app( const char *app_const ) {
  int error_code = -1;
  mrb_state *mrb = mrb_open();

  if ( mrb == NULL )
    return error_code;
  
  mrb_value app = mrb_const_get(
    mrb,
    mrb_obj_value( mrb->object_class ),
    mrb_intern_cstr( mrb, app_const )
  );

  mrb_funcall( mrb, app, "run", 0 );

  if ( mrb->exc ) {
    mrb_print_error( mrb );
  } else {
    error_code = 0;
  }

  mrb_close( mrb );

  return error_code;
}

void mrb_cura_examples_gem_init( mrb_state *mrb ) {
}

void mrb_cura_examples_gem_final( mrb_state *mrb ) {
}
