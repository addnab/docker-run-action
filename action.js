'use strict'
const child_process = require('child_process')
var child = child_process.spawn(__dirname + '/action.sh', [], { stdio: 'inherit' })

// kill child on signals SIGINT and SIGTERM
function handle(signal) {
  console.log('[33mForwarding signal ' + signal + ' to child process[0m')
  // Escalate signal INT -> TERM -> KILL
  // https://github.com/ringerc/github-actions-signal-handling-demo
  if (signal == 'SIGINT') { signal = 'SIGTERM' }
  else if (signal == 'SIGTERM') { signal = 'SIGKILL' }
  child.kill(signal)
}
process.on('SIGINT', handle)
process.on('SIGTERM', handle)

// exit if child exits
child.on('exit', function (exit_code) {
  exit_code = exit_code !== null ? exit_code : 143
  process.exit(exit_code)
})

// keep process running
setInterval(function () { }, 10000);
