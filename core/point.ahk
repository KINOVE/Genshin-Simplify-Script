class Point {
    __New(x := '', y := '') {
        this.x := x
        this.y := y
        this.x0 := x
        this.y0 := y
    }

    refresh_pos(game_width, game_height) {
        if this.x0 != '' {
            this.x := this.x0 * game_width / 2560
        }
        if this.y0 != '' {
            this.y := this.y0 * game_height / 1080
        }
    }
}