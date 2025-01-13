// main.go
package main

import (
	"syscall/js"
)

// ゲームの状態を管理する構造体
type GameState struct {
	PlayerY     float64
	PlayerX     float64
	IsJumping   bool
	Velocity    float64
	Obstacles   []Obstacle
	Score       int
	IsGameOver  bool
}

// 障害物の構造体
type Obstacle struct {
	X float64
	Y float64
}

var game GameState

// 初期化関数
func initGame() {
	game = GameState{
		PlayerY:   300, // 地面の高さ
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
func jump() {
	if !game.IsJumping {
		game.IsJumping = true
		game.Velocity = -15 // 上向きの初速度
	}
}

// ゲームの更新処理
func update() {
	// プレイヤーの物理演算
	if game.IsJumping {
		game.PlayerY += game.Velocity
		game.Velocity += 0.8 // 重力

		// 地面との衝突判定
		if game.PlayerY >= 300 {
			game.PlayerY = 300
			game.IsJumping = false
			game.Velocity = 0
		}
	}

	// 障害物の移動
	for i := range game.Obstacles {
		game.Obstacles[i].X -= 5 // 左に移動

		// 画面外に出たら右端に戻す
		if game.Obstacles[i].X < -50 {
			game.Obstacles[i].X = 800
			game.Score++
		}

		// 衝突判定
		if checkCollision(game.PlayerX, game.PlayerY, game.Obstacles[i].X, game.Obstacles[i].Y) {
			game.IsGameOver = true
		}
	}
}

// 衝突判定関数
func checkCollision(playerX, playerY, obstacleX, obstacleY float64) bool {
	return (playerX+30 > obstacleX &&
		playerX < obstacleX+30 &&
		playerY+30 > obstacleY-30)
}

// JavaScript側に状態を返す
func getGameState() interface{} {
	return map[string]interface{}{
		"playerY":    game.PlayerY,
		"playerX":    game.PlayerX,
		"obstacles":  game.Obstacles,
		"score":      game.Score,
		"isGameOver": game.IsGameOver,
	}
}

func main() {
	c := make(chan struct{}, 0)
	
	// 初期化
	initGame()

	// JavaScriptから呼び出せる関数を登録
	js.Global().Set("wasmJump", js.FuncOf(func(this js.Value, args []js.Value) interface{} {
		jump()
		return nil
	}))

	js.Global().Set("wasmUpdate", js.FuncOf(func(this js.Value, args []js.Value) interface{} {
		update()
		return getGameState()
	}))

	<-c
}