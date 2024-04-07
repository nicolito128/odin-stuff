package main

import "core:fmt"

Node :: struct {
    value  : int,
    next   : ^Node,
}

make_node :: proc(value: int) -> Node {
    return Node{value, nil}
}

List :: struct {
    head : ^Node
}

make_list :: proc() -> List {
    return List{nil}
}

list_insert :: proc(list: ^List, value: int) {
    if list != nil {
        elem := make_node(value)
        elem.next = list.head

        list.head = &elem
    }
}

main :: proc() {
    list := make_list()
    list_insert(&list, 128)

    fmt.println(list.head)
}