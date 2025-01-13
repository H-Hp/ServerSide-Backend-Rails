// main.go
package main

import (
    "syscall/js"
    "encoding/json"
)

// ゲームの状態を管理する構造体
type GameState struct {
    PlayerY     float64 `json:"playerY"`
    PlayerX     float64 `json:"playerX"`
    IsJumping   bool    `json:"isJumping"`
    Velocity    float64 `json:"velocity"`
    Obstacles   []Obstacle `json:"obstacles"`
    Score       int     `json:"score"`
    IsGameOver  bool    `json:"isGameOver"`
}

// 障害物の構造体
type Obstacle struct {
    X float64 `json:"x"`
    Y float64 `json:"y"`
}

var game GameState

// 初期化関数
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

// ジャンプ処理
func jump(this js.Value, args []js.Value) interface{} {
    if !game.IsJumping {
        game.IsJumping = true
        game.Velocity = -15
    }
    return nil
}

// ゲームの更新処理
func update(this js.Value, args []js.Value) interface{} {
    // プレイヤーの物理演算
    if game.IsJumping {
        game.PlayerY += game.Velocity
        game.Velocity += 0.8

        if game.PlayerY >= 300 {
            game.PlayerY = 300
            game.IsJumping = false
            game.Velocity = 0
        }
    }

    // 障害物の移動
    for i := range game.Obstacles {
        game.Obstacles[i].X -= 5

        if game.Obstacles[i].X < -50 {
            game.Obstacles[i].X = 800
            game.Score++
        }

        // 衝突判定
        if checkCollision(game.PlayerX, game.PlayerY, game.Obstacles[i].X, game.Obstacles[i].Y) {
            game.IsGameOver = true
        }
    }

    // JSONとしてゲーム状態を返す
    jsonState, _ := json.Marshal(game)
    return js.ValueOf(string(jsonState))
}

// 衝突判定関数
func checkCollision(playerX, playerY, obstacleX, obstacleY float64) bool {
    return (playerX+30 > obstacleX &&
        playerX < obstacleX+30 &&
        playerY+30 > obstacleY-30)
}

func main() {
    c := make(chan struct{}, 0)
    
    // 初期化
    initGame()

    // JavaScriptから呼び出せる関数を登録
    js.Global().Set("wasmJump", js.FuncOf(jump))
    js.Global().Set("wasmUpdate", js.FuncOf(update))

    <-c
}