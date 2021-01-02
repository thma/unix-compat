{-# LANGUAGE CPP #-}
module System.PosixCompat.Signals (
    Signal
  , Handler(..)
  , SignalInfo(..)
  , SignalSpecificInfo(..)
  , sigTERM
  , sigHUP
  , sigQUIT
  , sigUSR2  
  , sigCHLD
  , installHandler
  , signalProcess
) where

#ifndef mingw32_HOST_OS

import System.Posix.Signals

#else

import System.PosixCompat.Types ( ProcessID, UserID )

data Resource
  = ResourceCoreFileSize
  | ResourceCPUTime
  | ResourceDataSize
  | ResourceFileSize
  | ResourceOpenFiles
  | ResourceStackSize
  | ResourceTotalMemory
  deriving Eq

type Signal = CInt

type CInt = Int32
newtype Int32 = I32 Int deriving Show


sigTERM :: Signal
sigTERM = I32 15
sigHUP :: Signal
sigHUP = I32 9
sigQUIT :: Signal
sigQUIT = I32 10
sigUSR2 :: Signal
sigUSR2 = I32 8
sigCHLD :: Signal
sigCHLD = I32 7

data Handler = Default
             | Ignore
             -- not yet: | Hold
             | Catch (IO ())
             | CatchOnce (IO ())
             | CatchInfo (SignalInfo -> IO ())     -- ^ @since 2.7.0.0
             | CatchInfoOnce (SignalInfo -> IO ()) -- ^ @since 2.7.0.0
--  deriving (Typeable)

installHandler :: Signal
               -> Handler
               -> Maybe SignalSet       -- ^ other signals to block
               -> IO Handler            -- ^ old handler
installHandler sig handler _otherSignals = do
  print $ "installHandler: " ++ show sig
  return handler

signalProcess :: Signal -> ProcessID -> IO ()
signalProcess signal processID = do
  print $ "signalProcess: " ++ show signal ++ " to process: " ++ show processID
  return ()

-- | Information about a received signal (derived from @siginfo_t@).
--
-- @since 2.7.0.0
data SignalInfo = SignalInfo {
      siginfoSignal   :: Signal,
      siginfoError    :: Errno,
      siginfoSpecific :: SignalSpecificInfo
  }

-- | Information specific to a particular type of signal
-- (derived from @siginfo_t@).
--
-- @since 2.7.0.0
data SignalSpecificInfo
  = NoSignalSpecificInfo
  | SigChldInfo {
      siginfoPid    :: ProcessID,
      siginfoUid    :: UserID,
      siginfoStatus :: ProcessStatus
    }

type Errno = Int
type ProcessStatus = Int   
type SignalSet = Int 

#endif