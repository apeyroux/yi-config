import Control.Monad.State.Lazy
import Data.List
import Lens.Micro.Platform
import System.Environment

import Yi
import Yi.Config.Simple (globalBindKeys, theme, addMode)
import Yi.Config.Simple.Types
import Yi.Config.Default.HaskellMode (configureHaskellMode)
import Yi.Config.Default.JavaScriptMode (configureJavaScriptMode)
import Yi.Config.Default.MiscModes (configureMiscModes)
import Yi.Config.Default.Emacs (configureEmacs)
import Yi.Config.Default.Vty (configureVty)
import Yi.Fuzzy

main :: IO ()
main = do
  files <- getArgs
  let openFileActions = intersperse (EditorA newTabE) (map (YiA . openNewFile) files)
  cfg <- execStateT
         (runConfigM (myConfig >> (startActionsA .= openFileActions)))
         defaultConfig
  startEditor cfg Nothing

myConfig :: ConfigM ()
myConfig = do
  configureVty
  configureEmacs
  configureHaskellMode
  configureJavaScriptMode
  configureMiscModes
  globalBindKeys $ metaCh 'v' ?>>! splitE