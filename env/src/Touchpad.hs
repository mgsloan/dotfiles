module Touchpad where

import XMonad
import qualified XMonad.Util.ExtensibleState as State

import Misc
import Monad

data TouchpadMode = TouchpadInactive | TouchpadNormal
  deriving (Eq, Ord, Enum, Bounded, Read, Show, Typeable)

instance ExtensionClass TouchpadMode where
  initialValue = TouchpadInactive
  extensionType = PersistentExtension

cycleTouchpad :: MX ()
cycleTouchpad = do
  x <- toMX State.get
  let x' = nxt x
  setTouchpad x'
  toMX $ State.put x'

setTouchpad :: TouchpadMode -> MX ()
setTouchpad x = spawn $
  "xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Device Enabled' " ++
  case x of
    TouchpadInactive -> "0"
    TouchpadNormal -> "1"