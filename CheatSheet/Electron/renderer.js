const quotes = [
    { text: "人生は自分で創り出すものだ。", author: "アルベルト・アインシュタイン" },
    { text: "成功とは失敗から失敗へと情熱を持って進むことである。", author: "ウィンストン・チャーチル" },
    { text: "すべての人生は実験である。実験が多ければ多いほど良い。", author: "ラルフ・ワルド・エマーソン" },
    { text: "人生において重要なのは、人生があなたに何をしてくれるかではなく、あなたが人生に何をするかだ。", author: "ジョン・F・ケネディ" },
    { text: "未来を予測する最善の方法は、それを創造することだ。", author: "アラン・ケイ" }
];

const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEEAD', '#D4A5A5', '#9B59B6'];
const fontSizes = ['24px', '28px', '32px', '36px', '40px'];
const fontWeights = ['normal', 'bold'];

function getRandomItem(array) {
    return array[Math.floor(Math.random() * array.length)];
}

function updateQuote() {
    const quote = getRandomItem(quotes);
    const quoteElement = document.getElementById('quote');
    const authorElement = document.getElementById('author');

    // スタイルをランダムに設定
    quoteElement.style.color = getRandomItem(colors);
    quoteElement.style.fontSize = getRandomItem(fontSizes);
    quoteElement.style.fontWeight = getRandomItem(fontWeights);
    
    authorElement.style.color = getRandomItem(colors);
    authorElement.style.fontSize = '20px';

    quoteElement.textContent = quote.text;
    authorElement.textContent = `- ${quote.author}`;
}

// 3秒ごとに名言を更新
setInterval(updateQuote, 3000);
updateQuote(); // 初回表示