-- This file is the starting point for plugins management.
-- The 'install' subdirectory contains the list of plugins which
-- have to be installed, by means of an arbitrary number of .lua
-- files returning the corresponding plugins specs. The return values
-- of all these files are going to be merged by lazy.
--
-- This file, together with the whole content of the 'install'
-- directory is watched for changes and will issue a lazy install
-- (and clean) when anything is changed.
--
-- Additionally, this script will download and install lazy in the
-- proper directory, if not found.

-- Install lazy.nvim if not found
require("plugins.bootstrap").bootstrap()

-- Install plugins whose spec is found in the 'install' subdirectory
require("lazy").setup("plugins.install", {})

-- Autocommands related to plugins management, e.g. auto-install
-- when config changes
require("plugins.autocommands")
