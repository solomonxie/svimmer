-- REF: https://github.com/David-Kunz/gen.nvim

 require('gen').setup({
       opts = {
           model = 'deepseek/smallest',  -- The default model to use.
           quit_map = 'q',  -- Keymap to close the response window.
           retry_map = '<c-r>',  -- Keymap to re-send the current prompt.
           accept_map = '<c-cr>',  -- Keymap to replace the previous selection with the last result.
           host = 'localhost',  -- The host running the DeepSeek service.
           port = '11434',  -- The port on which the DeepSeek service is listening.
           display_mode = 'float',  -- Display mode: 'float', 'split', or 'horizontal-split'.
           show_prompt = false,  -- Show the prompt submitted to DeepSeek.
           show_model = false,  -- Show which model you are using.
           no_auto_close = false,  -- Never closes the window automatically.
           file = false,  -- Write the payload to a temporary file.
           hidden = false,  -- Hide the generation window.
           init = function(options)
               -- Start DeepSeek server if not already running
               pcall(io.popen, 'deepseek serve > /dev/null 2>&1 &')
           end,
           command = function(options)
               -- Prepare the body for the curl command
               local body = string.format([[
                   {
                       "model": "%%s",
                       "prompt": "$prompt",
                       "stream": true
                   }
               ]], options.model)

               -- Return the formatted curl command
               return string.format('curl --silent --no-buffer -X POST http://%%s:%%s/api/chat -d "%%s"', options.host, options.port, body)
           end,
           result_filetype = 'markdown',  -- Filetype for the result buffer.
           debug = false,  -- Print errors and command run.
       },
   })
