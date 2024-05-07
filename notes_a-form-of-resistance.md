# A Form of Resistance: Manipulating Web Forms

A workshop for LibCon 2024.

Scheduled for the last day of LibCon, at 12 PM Eastern.

## Workshop description

We all use forms every day. While they vary a great deal, we know how they usually work, and we adjust our behaviors to suit each website. But when a form doesn't work the way we expect, it can cause us confusion, frustration, or helplessness. In the worst cases, forms can deny us our own lived identities: our genders, our titles, or our names.

What can we do? Well, sometimes we have options beyond the ones the form gives us. In this workshop, I will discuss using browsers’ developer tools to get a look at how web forms are constructed. I’ll demonstrate techniques for modifying forms, inviting participants to try out these techniques on forms custom-made for this workshop.

You only need to know [what HTML markup looks like](https://gist.github.com/amclark42/ace2c44b1c987d91fb5a79eefad34662). No coding experience is necessary, only an openness to discussing ethical web-citizenry, data collection, and/or web design.

## Outline

I'll have 45 minutes.

1. Background — why this matters
2. Demonstration of browser tools
  1. What they show
  2. How to navigate with them
3. Try it on any webpage
4. Questions
5. Put link to website in chat
6. Demonstration of browser tools — modifying a simple form
  1. Change a few attributes
  2. Delete a form component
7. Try it + Questions
8. Under the hood + caveats
  1. Where does your data go?
  2. "Backend" architecture
    1. Form acceptance criteria
    2. Databases
  3. To what purpose are they collecting this data? Why might they need it?
  4. "Frontend" architecture
    1. HTML custom elements
    2. Javascript monitoring form components and submission
9. Questions/discussion/experimenting with other custom forms

## On implementation

I'll need:

- Links to reference materials
  - Browser developer tools documentation
    - Firefox, Chrome, Safari, (Edge?)
  - HTML elements
  - In-depth web architecture, tech explanations
- Slides with bullet points or graphics to explain concepts
- Boutique forms for practice/experimentation
  - Simple form — ~~radio buttons,~~ text field, maybe hidden input
  - 

## Script

<!-- intelligent intro goes here -->

<!-- Here's the thing about the modern web: It's hyper-concentrated into a few corporate hands, each of which has a vested interest in tracking your every movement, and obfuscating their tech — not for your protection, but for theirs. This is not something I've studied but it's something I've noticed. There is more a trend toward making posts and content on established or new platforms. People still make their own websites by hand, but many people don't. This is a reasonable tradeoff. I can get my fanart out to my small community without having to pay for website hosting, domains. But the thing you may trade away is your ability to learn what's under the hood of your browser, how the internet works and what tools are available to you. You don't need to have programming experience to do anything that I'm going to show you today. All you need is a browser, and a net connection, and a willingness to experiment a little. -->

Let's talk forms. Forms are interesting bits of websites to me, because they're so interactive, like a conversation between the website creator and me the user. They tell you what information, what *data* is important to this website. Sometimes you can infer how they're going to use it. Because the website creators bring their own biases to the table, however, forms are one of the biggest places where even an abled person, someone who can seamlessly engage with the internet for hours a day, can have a moment where they realize, "oh. This wasn't built with me in mind." Or, "this isn't *for* me."

An example. I usually fly with Southwest Airlines. Generally I have a pretty good opinion of them (at least compared to other airlines), but every time I've booked a flight home in the last few years, there's been one part of the traveler registration form that always stops me. They ask for the intended traveler's sex. Specifically, they're looking for the gender marker that matches the one on my photo ID. The form input only gives me two options, "M" for "male", and "F" for "female". However, my photo ID is my Massachusetts driver's license, which *actually* lists me as "X", for non-binary. Southwest's form requires me to misgender myself every time, and what *really* gets me is that it doesn't even follow its own reported goal of matching the identification I'll be presenting at the ticket counter.

When you have this disconnect with forms, there's often no easy recourse. You have a choice: walk away from the site, search out an email address or call center to try to contact a real human... or, hold your nose and use the form anyway. Sometimes, that's all you can do. I continue to fly home to Chicago on a Southwest flight every year for Christmas, because seeing my family is more important to me that picking a fight with a major airline.

But sometimes, because of the work I do, I know that there *is* another option. You don't need to have programming experience to do anything that I'm going to show you today. All you need is a browser, and a net connection, and a willingness to experiment a little.

Modern browsers come bundled with "web development tools". These are windows that let people peek beneath the hood of any web page. These tools let you see how the browser is interpreting the HTML source code, and how it applies styling rules. In my work life, these tools let me debug my code, and quickly test out new styles. But these tools can be used by anyone, not just developers!

Let me show you how this works in Firefox. There are a couple of ways to get at the Firefox Developer Tools. You can navigate there through the hamburger menu, or use the command <kbd>Ctrl Shift i</kbd>. I usually use the right-click or context menu method. I place my mouse cursor over something I want to look at, and right-click or <kbd>Ctrl</kbd>-click it. In the menu that appears, I choose the "Inspect" option. When I do that, a window appears, showing me the HTML element corresponding to the thing I clicked on, and any CSS rules that are defining how the thing is displayed.

It's worth noting that while most modern browsers have these tools, the names of these tools, and how you get to them or use them, may be different. Safari hides the tools by default unless you turn the setting on, but they're still there!

- [Firefox](https://firefox-source-docs.mozilla.org/devtools-user/)
- [Google Chrome](https://developer.chrome.com/docs/devtools/) (and other Chromium-based browsers, e.g. Brave)
- [Microsoft Edge](https://learn.microsoft.com/en-us/microsoft-edge/devtools-guide-chromium/overview)
- [Safari](https://developer.apple.com/documentation/safari-developer-tools)

Now, I'd like everyone to take 5 to 8 minutes to visit a web page with a form. Try using your browser's developer tools to examine what the form looks like under the hood. Click around, try moving your mouse around the interface and see what happens. (If you're using Safari, you're going to need to turn on the developer tools first.) In the meantime, I'll drink some water and take a look at chat.

**After 5 minutes:** It's been 5 minutes, how is everyone doing? Does anyone have any questions or comments about what they're seeing?

**After questions or 8 minutes:** Okay, y'all, let's gather back in the Zoom call. I want to show you two techniques in this Inspector tool. The Inspector doesn't just *show* you how the browser interprets the HTML, it lets you *change* the page in your browser. When you're navigating through this HTML tree, you can right-click or <kbd>Ctrl</kbd>-click on any element and edit it. You can also double-click to change attribute values. <!-- I should gloss elements and attributes -->

Here is a web form that I created. Let's Inspect the text box where I'm supposed to fill in my name. We can see that the text box corresponds to an HTML "input" element. The "input" element has an ID of "input-name", and a name of "fname". It's also required.

Let's walk through what this is telling us. The ID attribute *here* is giving the text box a local, machine-readable identifier. Because the `<input>` has an identifier, the label "First name" can say that it is linked with that `<input>`. As sighted humans, we can assume that "First name" is a prompt for the text box below it. But by linking the two elements, the web page is also telling screen readers that the two are related.

When you send the form, the *name* of the element is paired with the *value* you type in. So if I were to put my name in — "Ash" — and submit the form, the data would look like "fname=Ash".

We can also see that there's a "required" attribute on the text box, indicating that I *have to* fill out this field if I want to submit the form.

But what if I *didn't* want to submit my name? I have two options. I can use the context menu to delete the element entirely. *Or* I can remove the "required" attribute, by double-clicking on the attribute, selecting all of its text. Then I can just hit the backspace or delete button, and hit enter/return. Now I don't need to fill in the form at all, I can just hit submit and be done!

Oh. Oh dear. Y'all, this web page is telling me I'm not cool! I can't stand for that! Well *now* I'm pissed, so I'll just be *deleting* the first name field because that's quicker than making it optional. And — aha, here's another form input. You see it's got the "hidden" type on it. Websites use hidden form elements to pass on useful information that they don't want users to have to edit. It's usually a convenience thing, but in this case, someone was being real sneaky. I'll edit the value and... *there* we go. Coolness established.

Before we jump into practice, does anyone have any questions or comments about anything so far?

All righty, I've set up a page with a couple of example forms in it, including this one. They'll all lead to a web page that stores no data but does dutifully report back the data you've given it, so you can see how your changes have affected the request. You'll probably only have time for one right now.

Okay, have fun! I'll call us back in 5 to 8 minutes. Feel free to leave a message in chat or raise your hand if you need any help.

**After 5 minutes:** We're at five minutes. While folks are wrapping up with their experiments, does anyone have any questions?

**After questions or 8 minutes:** 