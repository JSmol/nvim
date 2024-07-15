
vim.notify('what the fuck!')
print('haaaaaaaalo')

function on_exit(val)
  -- val.code 
  -- val.signal 
  -- val.stderr 
  -- val.stdout 
  print('exited', vim.inspect(val))
end

opts = {
  cwd = '.',
  env = {
     
  }
}



vim.system({'echo', 'hihi'}, {}, on_exit)

                   -- • cwd: (string) Set the current working directory for the
                   --   sub-process.
                   -- • env: table<string,string> Set environment variables for
                   --   the new process. Inherits the current environment with
                   --   `NVIM` set to |v:servername|.
                   -- • clear_env: (boolean) `env` defines the job environment
                   --   exactly, instead of merging current environment.
                   -- • stdin: (string|string[]|boolean) If `true`, then a pipe
                   --   to stdin is opened and can be written to via the
                   --   `write()` method to SystemObj. If string or string[] then
                   --   will be written to stdin and closed. Defaults to `false`.
                   -- • stdout: (boolean|function) Handle output from stdout.
                   --   When passed as a function must have the signature
                   --   `fun(err: string, data: string)`. Defaults to `true`
                   -- • stderr: (boolean|function) Handle output from stderr.
                   --   When passed as a function must have the signature
                   --   `fun(err: string, data: string)`. Defaults to `true`.
                   -- • text: (boolean) Handle stdout and stderr as text.
                   --   Replaces `\r\n` with `\n`.
                   -- • timeout: (integer) Run the command with a time limit.
                   --   Upon timeout the process is sent the TERM signal (15) and
                   --   the exit code is set to 124.
                   -- • detach: (boolean) If true, spawn the child process in a
                   --   detached state - this will make it a process group
                   --   leader, and will effectively enable the child to keep
                   --   running after the parent exits. Note that the child
                   --   process will still keep the parent's event loop alive
                   --   unless the parent process calls |uv.unref()| on the
                   --   child's process handle.


