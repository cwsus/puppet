#
# named groups
#
class named::groups (
) {
    group { 'named':
        ensure              => present,
    }
}
