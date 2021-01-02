{-# LANGUAGE CPP #-}
module System.PosixCompat.Directory (
        changeWorkingDirectory
    , closeFd
    , stdInput
    , stdOutput
    , stdError
    , forkProcess
    , createSession  
) where

#ifndef mingw32_HOST_OS

import System.Posix.Directory

#else

changeWorkingDirectory = undefined

closeFd = undefined

stdInput = undefined

stdOutput = undefined

stdError = undefined

forkProcess = undefined

createSession = undefined

#endif