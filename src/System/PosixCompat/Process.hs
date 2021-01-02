{-# LANGUAGE CPP #-}
module System.PosixCompat.Process (
      getProcessID
    , exitImmediately
) where

#ifndef mingw32_HOST_OS

import System.Posix.Directory

#else

import System.PosixCompat.Types ( ProcessID, CPid(..) )
import System.Exit

getProcessID :: IO ProcessID
getProcessID = do
  print "getProcessID"
  return $ CPid 1


exitImmediately :: ExitCode -> IO ()
exitImmediately code = do
  print $ "exitImmediately " ++ show code
  return ()

#endif