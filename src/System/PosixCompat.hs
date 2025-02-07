{-# LANGUAGE CPP #-}

{-|
The @unix-compat@ package provides portable implementations of parts of the
@unix@ package. On POSIX system it re-exports operations from the @unix@
package, on other platforms it emulates the operations as far as possible.
-}
module System.PosixCompat (
      module System.PosixCompat.Files
    , module System.PosixCompat.Temp
    , module System.PosixCompat.Time
    , module System.PosixCompat.Types
    , module System.PosixCompat.Unistd
    , module System.PosixCompat.User

    , module System.PosixCompat.Directory
    , module System.PosixCompat.Process
    , module System.PosixCompat.Resource
    , module System.PosixCompat.Signals

    , usingPortableImpl
    ) where

import System.PosixCompat.Files
import System.PosixCompat.Temp
import System.PosixCompat.Time
import System.PosixCompat.Types
import System.PosixCompat.Unistd
import System.PosixCompat.User

import System.PosixCompat.Directory
import System.PosixCompat.Process
import System.PosixCompat.Resource
import System.PosixCompat.Signals


-- | 'True' if unix-compat is using its portable implementation,
--   or 'False' if the unix package is simply being re-exported.
usingPortableImpl :: Bool
#ifdef mingw32_HOST_OS
usingPortableImpl = True
#else
usingPortableImpl = False
#endif

