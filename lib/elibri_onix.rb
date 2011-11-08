
require 'bigdecimal'
# Old ActiveSupport needs 'thread' to see Mutex:
require 'thread'
require 'active_support'
require 'active_support/core_ext'
require 'roxml'
require 'elibri_onix/version'
require 'elibri_onix/inspector'
require 'elibri_onix/releases'

$KCODE = "UTF-8"


module Elibri
  module ONIX
    module Release_3_0; end
    
  end
end

