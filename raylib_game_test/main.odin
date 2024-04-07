package main

import "vendor:raylib"

Window :: struct{
    width: i32,
    height: i32,
    title: cstring,
}

create_window :: proc(win: ^Window) {
    raylib.InitWindow(win.width, win.height, win.title)
}

game_loop :: proc(win: ^Window) {
    defer raylib.CloseWindow()

    player_pos := raylib.Vector2{f32(win.width/2), f32(win.height/2)}
    velocity: raylib.Vector2
    grounded: bool

    for !raylib.WindowShouldClose() {
        raylib.BeginDrawing()

        raylib.ClearBackground(raylib.BLUE)

        if raylib.IsKeyDown(.LEFT) {
            velocity.x = -400
        } else if raylib.IsKeyDown(.RIGHT) {
            velocity.x = 400
        } else {
            velocity.x = 0
        }

        velocity.y += 2000 * raylib.GetFrameTime()
        if grounded && raylib.IsKeyPressed(.SPACE) {
            velocity.y = -600
            grounded = false
        }

        player_pos += velocity * raylib.GetFrameTime()
        if player_pos.y > f32(raylib.GetScreenHeight() - 64) {
            player_pos.y = f32(raylib.GetScreenHeight() - 64)
            grounded = true
        }

        raylib.DrawRectangleV(player_pos, {64, 64}, raylib.GREEN)

        raylib.EndDrawing()
    }
}

main :: proc() {
    win := Window{1050, 620, "Raylib Game Test"}

    create_window(&win)
    game_loop(&win)
}