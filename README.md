# Ada

Zig build of the [Ada URL](https://github.com/ada-url/ada) parsing library.

## Usage

First, add to your `build.zig.zon`:

```bash
zig fetch --save git+https://github.com/braheezy/ada#3.2.4
```

Then update your `build.zig`:

```zig
const ada_dep = b.dependency("ada", .{});
const ada_artifact = ada_dep.artifact("ada");
// Where needed
<your compilation>.linkLibrary(ada_artifact);
```

Finally, in your source code:

```zig
const std = @import("std");
const c = @cImport({
    @cInclude("ada_c.h");
});

const url_string = "https://user:pass@127.0.0.1:8080/path?query=1#frag";
const parsed = c.ada_parse(
    url_string.ptr,
    url_string.len,
);

if (!c.ada_is_valid(parsed)) {
    // Remember to free C-allocated memory!
    c.ada_free(parsed);
    return error.InvalidUrl;
}

// do ada stuff
const protocol_c = c.ada_get_protocol(parsed);
const protocol = protocol_c.data[0..protocol_c.length];
std.debug.print("{s}", .{protocol});
// https
```

## Zig Bindings

For a light Zig wrapper around all of the Ada functionality, see [ada-zig](https://github.com/braheezy/ada-zig)
