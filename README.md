# Ada
Zig build of the [Ada URL](https://github.com/ada-url/ada) parsing library.

## Usage
First, add to your `build.zig.zon`:

```bash
zig fetch --save git+https://github.com/braheezy/ada#2.9.2
```

Then update your `build.zig`:

```zig
const ada_dep = b.dependency("ada", .{});
const ada_artifact = ada_dep.artifact("ada");
// Where needed
<your compilation>.linkLibrary(ada_artifact);
```
