# 🛒 FiveM Store Script - The Ultimate Shopping Experience! 🚀

Hey everyone! 👋 Welcome to the official GitHub repository for the coolest FiveM store script out there! This script lets players shop for awesome in-game items like vehicles, weapons, and even in-game money, all from within the game.

**✨ Features That Make This Store Awesome! ✨**

* **Easy Coin Gifting:** Admins can easily give coins to players right from the server console!
* **Unique Store ID:** Each store has its own ID, making management a breeze.
* **Buy Cool Stuff:** Players can purchase weapons, vehicles, and in-game money to enhance their gameplay.
* **Discord Logs:** Every purchase is logged to Discord using the Discord API, so you can keep track of everything!
* **Tebex Integration:** A handy button in the store redirects players to your Tebex store link for easy donations or premium purchases.
* **Fully Customizable Look:** You can change the entire look and feel of the store in the config file. No need to mess with the code!
* **Super Easy Setup:** Get your store up and running in no time!

**🛑 Important! Beware of Scams! 🛑**

Just a friendly heads-up! This is the **original** and **only official** version of this script. If you find it anywhere else, it's likely a scam. Please support the original creator and stay safe!

**🛠️ Installation - Get Your Store Ready! 🛠️**

1.  **SQL Time!** First, you'll need to import the `store.sql` file into your server's database.
    * **Troubleshooting:** If you get an error during the SQL import, it might be because you already have an `ID` column in your `users` table. Try deleting that column and running the SQL again.
2.  **Script Setup:** Place the `fivem-store-script` folder into your server's `resources` directory.
3.  **Customize!** Open the `config.lua` file and customize the store to your liking. You can change colors, item prices, categories, and much more!
4.  **Ensure It!** Add `ensure fivem-store-script` to your `server.cfg` file to make sure the script starts when your server does.
5.  **Restart Your Server:** Restart your FiveM server, and you should be good to go!

**⚙️ Configuration - Make It Your Own! ⚙️**

The `config.lua` file is where all the magic happens! You can easily adjust:

* Store name and appearance
* Currency settings
* Item categories and prices
* Tebex link
* Discord webhook for logs
* And much more!

**🤝 Contributing - Help Make It Even Better! 🤝**

Got ideas for improvements or found a bug? Feel free to contribute! Just fork the repository and submit a pull request with your changes. Let's make this script even better together!

**📜 License**

This script is released under License

**🎉 Enjoy Your Awesome New Store! 🎉**

We hope you and your players enjoy using this script! If you have any questions or need help, feel free to check the issues or discussions tab. Happy shopping! 😊
