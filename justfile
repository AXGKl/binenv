set unstable

set script-interpreter := ['uv', 'run', '--script']

[script]
release:
  # /// script
  # requires-python = ">=3.10"
  # dependencies=["pyyaml"]
  # ///
  import os
  from datetime import datetime as dt
  vers = os.popen('git tag').read().splitlines()
  bv = dt.today().strftime('%Y.%m.%d')
  for i in range(1000):
    v = f'{bv}.{i} '.split('.0 ')[0].strip()
    if v not in vers:
      break
  os.system(f'git tag {v} && git push origin {v}')

[script]
fix:
  # /// script
  # requires-python = ">=3.10"
  # dependencies=["pyyaml"]
  # ///
  import yaml
  bp, fixed = breakpoint, []
  fn = 'distributions/distributions.yaml'
  with open(fn) as f: data = yaml.safe_load(f)
  for k, spec in data['sources'].items():
     b = spec['install'].get('binaries')
     if isinstance(b, list) and len(b) == 1:
        f = b[0]
        if f[0] != '^': f = f'^{f}'
        if f[-1] != '$': f = f'{f}$'
        if f != b[0]:
           fixed.append(k)
           spec['install']['binaries'] = [f]
           print(f'{k} fixed: {b[0]} -> {f}')
  if fixed:
    print(f'fixed {len(fixed)} entries')
    with open(fn, 'w') as f: f.write(yaml.safe_dump(data))
  else:
    print('all well already')



