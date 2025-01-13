// main.go
package main

import (
    "syscall/js"
    "encoding/json"
)

// グローバル変数として関数を保持
var (
    updateFunc js.Func
    jumpFunc   js.Func
)

type GameState struct {
    PlayerY     float64 `json:"playerY"`
    PlayerX     float64 `json:"playerX"`
    IsJumping   bool    `json:"isJumping"`
    Velocity    float64 `json:"velocity"`
    Obstacles   []Obstacle `json:"obstacles"`
    Score       int     `json:"score"`
    IsGameOver  bool    `json:"isGameOver"`
}

type Obstacle struct {
    X float64 `json:"x"`
    Y float64 `json:"y"`
}

var game GameState

func initGame() {
    game = GameState{
        PlayerY:   300,
        PlayerX:   50,
        IsJumping: false,
        Velocity:  0,
        Obstacles: []Obstacle{
            {X: 400, Y: 300},
            {X: 700, Y: 300},
            {X: 1000, Y: 300},
        },
        Score:      0,
        IsGameOver: false,
    }
}

func registerCallbacks() {
    // 関数を定義して保持
    updateFunc = js.FuncOf(func(this js.Value, args []js.Value) interface{} {
        return update()
    })
    jumpFunc = js.FuncOf(func(this js.Value, args []js.Value) interface{} {
        jump()
        return nil
    })

    // グローバルオブジェクトに関数を登録
    js.Global().Set("wasmUpdate", updateFunc)
    js.Global().Set("wasmJump", jumpFunc)

    // 初期化完了のフラグを設定
    js.Global().Set("wasmInitialized", js.ValueOf(true))
}

func jump() {
    if !game.IsJumping {
        game.IsJumping = true
        game.Velocity = -15
    }
}

func update() interface{} {
    if game.IsJumping {
        game.PlayerY += game.Velocity
        game.Velocity += 0.8

        if game.PlayerY >= 300 {
            game.PlayerY = 300
            game.IsJumping = false
            game.Velocity = 0
        }
    }

    for i := range game.Obstacles {
        game.Obstacles[i].X -= 5

        if game.Obstacles[i].X < -50 {
            game.Obstacles[i].X = 800
            game.Score++
        }

        if checkCollision(game.PlayerX, game.PlayerY, game.Obstacles[i].X, game.Obstacles[i].Y) {
            game.IsGameOver = true
        }
    }

    jsonState, _ := json.Marshal(game)
    return js.ValueOf(string(jsonState))
}

func checkCollision(playerX, playerY, obstacleX, obstacleY float64) bool {
    return (playerX+30 > obstacleX &&
        playerX < obstacleX+30 &&
        playerY+30 > obstacleY-30)
}

func main() {
    c := make(chan struct{}, 0)
    
    initGame()
    registerCallbacks()

    <-c
}