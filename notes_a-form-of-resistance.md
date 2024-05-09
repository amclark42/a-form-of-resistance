# A Form of Resistance: Manipulating Web Forms

A workshop for LibCon 2024.

Scheduled for the last day of LibCon, at 12 PM Eastern.

## Workshop description

We all use forms every day. While they vary a great deal, we know how they usually work, and we adjust our behaviors to suit each website. But when a form doesn't work the way we expect, it can cause us confusion, frustration, or helplessness. In the worst cases, forms can deny us our own lived identities: our genders, our titles, or our names.

What can we do? Well, sometimes we have options beyond the ones the form gives us. In this workshop, I will discuss using browsers’ developer tools to get a look at how web forms are constructed. I’ll demonstrate techniques for modifying forms, inviting participants to try out these techniques on forms custom-made for this workshop.

You only need to know [what HTML markup looks like](https://gist.github.com/amclark42/ace2c44b1c987d91fb5a79eefad34662). No coding experience is necessary, only an openness to discussing ethical web-citizenry, data collection, and/or web design.

## Script

Hi everyone! For those who don't know me, I'm Ash Clark. My pronouns are e, em, eir, and I'm the XML Applications Developer for the Digital Scholarship Group and the Women Writers Project. A big part of my job is playing web developer: I make websites using collections of digital humanities data.

Before we dive in, I'd like to note that while I'm sharing my screen, I won't be able to read chat. To maintain my focus, I'll wait to catch up on chat until we're in the hands-on portions of the workshop. In the meantime, if you're having trouble with something or need me to slow down, leave a note in the chat and Regina will let me know.

Let's dive in. Forms are interesting bits of websites to me, because they're so interactive, like a conversation between the website creator and me-the-user. They tell you what information, what *data* is important to this website. Sometimes you can infer how they're going to use it. Because the website creators bring their own biases to the table, however, forms are one of the biggest places where even an abled person, someone who can seamlessly engage with the internet for hours a day, can have a moment where they realize, "oh. This wasn't built with me in mind." Or, more simply, "this isn't *for me*."

An example: I usually fly with Southwest Airlines. Generally I have a pretty good opinion of them (at least compared to other airlines), but every time I've booked a flight home in the last few years, there's been one part of the traveler registration form that always stops me. They ask for the intended traveler's sex. Specifically, they're looking for the gender marker that matches the one on my photo ID. The form input only gives me two options, "M" for "male", and "F" for "female". However, my photo ID is my Massachusetts driver's license, which *actually* lists me as "X", for non-binary. Southwest's form requires me to misgender myself every time, and what *really* gets me is that it doesn't even follow its own reported goal of matching the identification I'll be presenting at the ticket counter.

When you have this disconnect with forms, there's often no easy recourse. You have a choice: walk away from the site, search out an email address or call center to try to contact a real human... or, hold your nose and use the form anyway. Sometimes, that's all you can do. I continue to fly home to Chicago on a Southwest flight every year for Christmas, because seeing my family is more important to me that picking a fight with a major airline.

But, because of the work I do, I know that there *is* sometimes another option. That said, you don't need to do the work I do in order to exercise this option. You don't need to have programming experience to do anything that I'm going to show you today. All you need is a browser, and a net connection, and a willingness to experiment a little.

The secret is the "web development tools" that come bundled with pretty much every modern browser. These are windows that let people peek beneath the hood of any web page. These tools let you see how the browser is interpreting the HTML source code, and how it applies styling rules. In my work life, these tools let me debug my code, and quickly test out new styles. But these tools can be used by anyone, not just developers!

Let me show you how this works in Firefox. There are a couple of ways to get at the Firefox Developer Tools. You can navigate there through the hamburger menu, or use the command <kbd>Ctrl Shift i</kbd>. I usually use the right-click or context menu method. I place my mouse cursor over something I want to look at, and right-click or <kbd>Ctrl</kbd>-click it. In the menu that appears, I choose the "Inspect" option. When I do that, a window appears, showing me the HTML element corresponding to the thing I clicked on, and any CSS rules that are defining how the thing is displayed.

It's worth noting that while most modern browsers have these tools, the names of these tools, and how you get to them or use them, may be different.

Now, I'd like everyone to take 3 to 5 minutes to visit a web page with a form. Try using your browser's developer tools to examine what the form looks like under the hood. Click around, try moving your mouse around the interface and see what happens. (If you're using Safari, you're going to need to turn on the developer tools first.) In the meantime, I'll drink some water and catch up on chat.

<!-- above was 5 min -->

**After 5 minutes:** It's been 5 minutes, how is everyone doing? Does anyone have any questions or comments about what they're seeing?

**After questions or 8 minutes:** Okay y'all, let's gather back in the Zoom call. I want to show you two techniques in this Inspector tool. The Inspector doesn't just *show* you how the browser interprets the HTML, it lets you *change* the page in your browser. When you're navigating through this HTML tree, you can right-click or <kbd>Ctrl</kbd>-click on any element and edit it. You can also double-click to change certain values. <!-- I should gloss elements and attributes -->

Here is a web form that I created. Let's Inspect the text box where I'm supposed to fill in my name. I do that by putting my cursor over the text field, right-clicking, and choosing the "Inspect" option at the bottom. Now we can see that the text box corresponds to an HTML "input" element. The "input" element has an ID of "input-name", and a name of "fname". It's the "text" type of input, and it's required.

Let's walk through what this is telling us. First, the `<input>` element has a lot of possible types. Under the hood, checkboxes, radio buttons, password and email fields, and even submit buttons are all encoded with the `<input>` element. What differentiates them is the value on this "type" attribute, and this is what tells the browser to render the form control you're used to seeing. This `<input>` is the "text" type, meaning it's a single-line text field. (The multiline text field is a separate element called "textarea".)

<!-- https://developer.mozilla.org/en-US/docs/Web/HTML/Element/Input -->

The ID attribute *here* is giving the text box a machine-readable identifier that's unique on this page. Because the `<input>` has an identifier, the label "First name" can say that it is linked with that `<input>`. Sighted folks can assume that "First name" is a prompt for the text box below it. But by linking the two elements, the web page is also telling screen readers that the two are related.

When you send the form, the *name* of the element is paired with the *value* you type in. So if I were to type my name in and submit the form, the website would receive a data packet containing "fname=Ash" (fname equals Ash).

We can also see that there's a "required" attribute on the text box, indicating that I *have to* fill out this field if I want to submit the form.

But what if I *didn't* want to submit my name? I have two options. I can use the context menu to delete the element entirely. *Or* I can remove the "required" attribute, by double-clicking on the attribute, selecting all of its text. Then I can just hit the backspace or delete button, and hit enter/return. Now I don't need to fill in the form at all, I can just hit submit and be done!

Oh. Oh dear. Y'all, this web page is telling me I'm not cool! I can't stand for that! Well *now* I'm pissed, so I'll just be *deleting* the first name field because that's quicker than making it optional. I'm returning back to the previous page, right-clicking the text field, and Inspecting it. Now I can context-click on the highlighted element and choose "Delete node" — and now it's gone!

Now we just need to find the source of that "am I cool" nonsense. There's a folded-up `<div>` down here, so let's unfold it and — aha, here's another `<input>` element. You see it's got the "hidden" type on it. Websites use hidden form elements to pass on useful information that they don't want users to have to edit. It's usually a convenience thing, but in this case, someone (wink) was being real sneaky. I'll double-click to change the value to "absolutely" in all-caps. Now I'll submit the page... *There* we go. Coolness established.

Before we jump into practice, does anyone have any questions or comments about anything so far?

<!-- above was 5 min -->

All righty, I've set up a page with a couple of example forms in it, including this one. They'll all lead to this web page. It stores no data but *does* dutifully report back the data you've given it, so you can see how your changes have affected the request. You'll probably only have time for one right now, so pick one and play around!

Okay, have fun! I'll call us back in 5 to 8 minutes. Feel free to leave a message in chat or unmute if you need any help in the meantime.

<!-- above was 1 min -->

**After 5 minutes:** We're at five minutes. While folks are wrapping up with their experiments, does anyone have any questions?

**After questions or 8 minutes:** Okay, come on back to the Zoom call, everyone. There's one more thing I want to talk about. By now you might be wondering, when do you use these techniques? When do you *not* use them?

I wrestled with that question a lot when I was writing this workshop, because I've mostly been going on vibes and my own conscience. While there are many forms that have annoyed or disgusted me, like Southwest's, I've only ever modified three forms in the wild, at least so far.

I think it comes down to this. This technique is, to be frank, a kind of hacking. **When I do it, I have to be prepared to face consequences for that action.** There might be no consequences for *me*, but I might be condemning some underpaid staff member to hours of data cleanup. Or, the people who coded the website might have been wise enough to check that my data matches their expectations, and the website might reject my hacked form. On the more serious end of the spectrum, major companies may consider even a benign hack to be a violation of their terms of service, and I may be kicked off their service or sued.

When I hack a form, I am saying *no*, I cannot sit with this. *No,* you should know better. *No,* **do** better. *No,* I am prepared to resist, and I will take any consequences that come from that resistance.

So, if the consequences are so potentially dire, why do this workshop at all?

The modern web favors no-code methods of making websites, meaning that fewer people are learning to use HTML and use the tools built into their browser. However, the no-code, drag-and-drop interfaces still produce HTML. Even if you never see it, the internet still runs on HTML. My colleague Syd Bauman likes to say that every third-grader should be taught regular expressions. I don't 100% agree, but I *do* think that *everyone* should have at least a little bit of power to understand how websites work under the hood, and to control their web browsing experience. If you never modify a form again ever, I will still be happy knowing that *y'all* now know how to get that glimpse under the hood, for any web page, at any time, for any reason.

I'll leave it there. Thank you all so much for walking through this with me. Does anyone have any last questions or comments?
